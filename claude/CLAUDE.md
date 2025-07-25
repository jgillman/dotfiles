# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Essential Development Commands

### Ruby/Rails Commands
- **Tests**: `bundle exec rspec` (comprehensive RSpec test suite)
- **Lint**: `bundle exec rubocop` (Ruby code style and quality)
- **Development server**: `bin/rails s` or via `Procfile.dev`
- **Single test**: `bundle exec rspec spec/path/to/test_spec.rb`
- **Security scan**: `bundle exec brakeman`

### JavaScript/Frontend Commands
- **Lint**: `yarn lint` (ESLint for JavaScript/TypeScript)
- **Tests**: `yarn test` (Jest test runner)
- **Test coverage**: `yarn test:coverage`
- **Type checking**: `yarn test:build` (TypeScript compilation)
- **Development**: `bin/vite dev` (Vite asset compilation)
- **Watch mode**: `yarn test:watch`

### Background Services
- **Sidekiq**: Multiple configurations for background job processing
- **Karafka**: Kafka message consumer framework
- **Clockwork**: Scheduled job management

## Multi-Application Architecture

This codebase contains **5 distinct applications** within a single Rails monolith:

1. **Explore** (`/app/controllers/explore/`, `/app/javascript/entrypoints/explore.jsx`)
   - Customer-facing e-commerce site
   - Main shopping experience and product catalog

2. **GBMC** (`/app/controllers/gbmc/`, `/app/javascript/entrypoints/gbmc.tsx`)
   - Goldbely Management Console (admin interface)
   - Internal operations and merchant management

3. **MDash** (`/app/controllers/mdash/`, `/app/javascript/entrypoints/mdash.jsx`)
   - Merchant dashboard for vendors
   - Order fulfillment and inventory management

4. **Prize** (`/app/controllers/prize/`, `/app/javascript/entrypoints/prize.jsx`)
   - Specialized interface for rewards/contests
   - Whitelabel merchant support

5. **Support** (`/app/controllers/support/`)
   - Customer support tools
   - GraphQL API for support operations

Each application has its own:
- Controller namespace
- JavaScript entrypoint
- CSS/styling
- Routes configuration

## Key Architecture Patterns

### Service Objects
- Located in `app/services/`
- Follow the pattern: `SomeService.new(params).call`
- Handle complex business logic outside of models/controllers

### Authorization
- **Pundit policies** in `app/policies/`
- Role-based permissions via Rolify gem
- Multi-tenant authorization support

### Data Access Patterns
- **Finders** in `app/finders/` for complex queries
- **Decorators** in `app/decorators/` using Draper pattern
- **Form objects** in `app/inputs/` for complex form handling

### Background Processing
- **Sidekiq workers** in `app/workers/`
- **Kafka consumers** in `app/consumers/`
- **Publishers** in `app/publishers/` for message publishing

### Frontend Architecture
- **React 17** with TypeScript
- **Vite** for asset bundling and hot reloading
- **Redux** for state management in some components
- **Separate entrypoints** for each application section

## Critical Business Domain Knowledge

### Shipping & Fulfillment System
- **ShippingCalendar** class manages complex delivery scheduling
- Multiple carrier integrations (UPS, FedEx, etc.)
- Pickup location management and scheduling
- Inventory limits and availability windows

### Financial Systems
- **Tax integration** with AvaTax
- **Payment processing** with Stripe and Braintree
- **Margin calculations** and commission tracking
- **Invoice generation** and billing workflows

### Multi-Tenant Support
- **Whitelabel merchants** with custom domains
- **Merchant-specific constraints** and routing
- **Custom branding** and configuration per merchant

## Testing Strategy

### RSpec Configuration
- Comprehensive test suite with extensive helpers
- **VCR** for external API testing
- **Factory Bot** for test data generation
- **Capybara** for feature testing
- **Shared examples** for common behaviors

### JavaScript Testing
- **Jest** with React Testing Library
- **Enzyme** for component testing
- **Mocking** for external dependencies
- **Coverage reporting** with SimpleCov

## Development Workflow Requirements

### Pre-commit Hooks
- **Husky** and **lint-staged** for git hooks
- **Prettier** for code formatting
- **ESLint** for JavaScript linting
- **RuboCop** for Ruby linting

### Community Guidelines
- **All features require PM intake** - no rogue feature development
- **Finish what you start** - no half-built PRs
- **Monitor post-deployment** for regressions and performance impacts
- **Be mindful of refactors** - assess user impact before changes

## External Integrations

### Payment & Financial
- Stripe, Braintree, AvaTax

### Shipping & Logistics
- UPS, FedEx, active_shipping gem

### Marketing & Analytics
- Datadog, Skylight, Rollbar
- Segment analytics, Google Analytics
- Mailchimp, Facebook Pixel

### Search & Data
- Elasticsearch via Searchkick
- Redis for caching and sessions
- PostgreSQL primary database

## Common Gotchas

- **Multi-application routing** - ensure you're working in the correct controller namespace
- **Whitelabel constraints** - some features are merchant-specific
- **Complex shipping logic** - the ShippingCalendar system has many dependencies
- **Background job dependencies** - ensure Sidekiq/Karafka are running for full functionality
- **Asset compilation** - use Vite for modern frontend tooling, not Webpacker

## Ruby Style: Minimal Use of Parentheses (Seattle.rb Style)

Follow the Seattle.rb Ruby style: use parentheses only when required for clarity or to avoid ambiguity. Otherwise, omit them for a cleaner, more idiomatic Ruby look. This applies to all Ruby code, including method calls, chained methods, and RSpec expectations/mocks.

**Examples:**

```ruby
some_object
  .do_something arg1
  .do_something_else arg2
  .finalize

allow rollbacker
  .to receive :current_branch_migrations
  .and_return current_migrations

expect rollbacker
  .to have_received :rollback_migration
  .with "20240627123457"
```

**Do this:**
```ruby
user
  .orders
  .where active: true
  .pluck :id
```

**Not this:**
```ruby
user.orders.where(active: true).pluck(:id)
expect(foo).to receive(:bar).with(:baz)
```

**Guidelines:**
- Omit parentheses for method calls unless required for clarity or to avoid ambiguity.
- Use parentheses for method definitions, or when passing multiple arguments and omitting them would be confusing.
- Prefer multi-line, leading period style for chained methods, with minimal parentheses.

## Ruby Style: Private Methods Underscore Prefix

All private Ruby methods should be named with a leading underscore (`_`). This makes it clear at a glance which methods are intended for internal use only.

**Example:**

```ruby
class Example
  def public_method
    # ...
  end

  private

  def _helper_method
    # ...
  end
end
```

**Guidelines:**
- Prefix all private method names with an underscore.
- Do not use the underscore prefix for public or protected methods.
