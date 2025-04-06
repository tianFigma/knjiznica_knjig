# syntax=docker/dockerfile:1
# This Dockerfile is designed for production, not development.

# Ensure the Ruby version matches the .ruby-version file
ARG RUBY_VERSION=3.3.6
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips sqlite3 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set production environment variables
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    SECRET_KEY_BASE="dummy_production_secret"

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install build dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile Gemfile.lock ./ 
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy the app code
COPY . .

# Make the rails executable
RUN chmod -R +x ./bin

# Precompile assets for production without secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# 🔄 Prepare database and seed it
RUN bundle exec rails db:prepare && bundle exec rails db:seed

# Final stage for the app image
FROM base

# Copy built artifacts: gems and application files
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER 1000:1000

# Entrypoint script for startup (no migration needed anymore since it's done in build)
ENTRYPOINT ["./bin/rails", "server", "-b", "0.0.0.0"]

# Expose port 3000 for the Rails server
EXPOSE 3000
