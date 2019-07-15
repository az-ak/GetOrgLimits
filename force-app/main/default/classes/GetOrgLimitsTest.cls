@isTest
private without sharing class GetOrgLimitsTest {
    @isTest static void testOrgLimits() {
        System.assert(GetOrgLimits.getAll().size() > 1, 'result size is not greater than 1');
    }
}