@isTest
private with sharing class CalculatorTests {
    
    @isTest
    static void testDivideByZero() {
        Integer numerator = 10;
        Integer denominator = 0;
        Boolean exceptionThrown = false;

        try {
            Decimal result = Calculator.divide(numerator, denominator);
        } catch (Calculator.CalculatorException e) {
            exceptionThrown = true;
            Assert.areEqual('You still cannot divide by zero', e.getMessage(), 'Expected a divide by zero exception');
        }

        System.Assert(exceptionThrown, 'An exception should have been thrown for dividing by zero');
    }

}