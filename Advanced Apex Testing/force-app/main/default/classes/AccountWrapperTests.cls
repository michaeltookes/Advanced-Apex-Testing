@IsTest
private class AccountWrapperTests {
  @TestSetup
  static void loadTestData() {
    // GIVEN
    Account acct = new Account(Name = 'ACME');
    insert acct;
    List<Opportunity> opps = TestFactory.generateOppsForAccount(acct.id, 1000.00, 5);
    insert opps;
  }
  @IsTest
  static void testPositiveRoundedAveragePrice() {
    // WHEN
    Account acct = [SELECT Id FROM Account LIMIT 1];
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // THEN
    Test.startTest();
      Assert.areEqual(
        acctWrapper.getRoundedAvgPriceOfOpps(),
        1000.00,
        'Expected to get 1000.00');
    Test.stopTest();
  }

  @IsTest
  static void testIsHighPriority() {
    Account highPriorityAcct = [SELECT Id FROM Account LIMIT 1];
    List<Opportunity> highPriorityOpps = TestFactory.generateOppsForAccount(highPriorityAcct.Id, 1500.00, 5);
    insert highPriorityOpps;
    AccountWrapper highPriorityWrapper = new AccountWrapper(highPriorityAcct);

    Test.startTest();
     Assert.areEqual(
        true, 
        highPriorityWrapper.isHighPriority(), 
        'Expected the account to be considered high priority');
    Test.stopTest();     
  }

  @IsTest
  static void testIsNotHighPriority() {
    Account nonHighPriorityAcct = [SELECT Id FROM Account LIMIT 1];
    List<Opportunity> nonHighPriorityOpps = TestFactory.generateOppsForAccount(nonHighPriorityAcct.Id, 500.00, 5);
    insert nonHighPriorityOpps;
    AccountWrapper nonHighPriorityWrapper = new AccountWrapper(nonHighPriorityAcct);

    Test.startTest();
     Assert.areEqual(
        false, 
        nonHighPriorityWrapper.isHighPriority(), 
        'Expected the account to NOT be considered high priority');
    Test.stopTest();     
  } 

}