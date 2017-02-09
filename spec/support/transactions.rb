# Tests that require pessimistic db locking require transactional fixtures false.
# Allow this functionality on a per test basis
def without_transactional_fixtures
  self.use_transactional_fixtures = false

  before(:all) do
    DatabaseCleaner.strategy = :truncation
  end

  yield

  after(:all) do
    DatabaseCleaner.strategy = :transaction
  end
end
