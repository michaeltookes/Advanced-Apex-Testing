@IsTest
private class ExternalSearchTests {
  @IsTest
  static void testPositiveMocking() {
    // GIVEN
    HTTPMockFactory mock = new HTTPMockFactory(
      200,
      'OK',
      'I found it!',
      new Map<String, String>()
    );
    Test.setMock(HttpCalloutMock.class, mock);
    // WHEN
    Test.startTest();
      String result = ExternalSearch.googleIt('epic search');
    Test.stopTest();
    // THEN
    Assert.areEqual('I found it!', result, 'Expected to receive mock response');
  }

  @isTest
  static void testNegativeMocking() {
    HTTPMockFactory mock = new HTTPMockFactory(
        500,
        'Internal Server Error',
        'Server Issue!',
        new Map<String, String>()
    );
    Test.setMock(HttpCalloutMock.class, mock);
    // WHEN
    Test.startTest();
      String result = ExternalSearch.googleIt('Server Issue!');
      try {
        result = ExternalSearch.googleIt('Server Not Found');
      } catch (ExternalSearch.ExternalSearchException exc) {
        System.assert(exc.getMessage().equalsIgnoreCase('Did not receive 200/500 status code.'));
      }
    Test.stopTest();
    //THEN
    Assert.areEqual('Server Issue!', result, 'Did not receive mock response');
  }

}