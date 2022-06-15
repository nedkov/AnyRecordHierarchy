global class ARHPostInstall implements InstallHandler {
  global void onInstall(InstallContext context) {
    if (context.previousVersion() == null) {
      Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();

      //Get Config Object Describe
      DescribeSObjectResult configObject = globalDescribe.get(
          'Configuration__c'
        )
        .getDescribe();

      //Get Object Fiels
      Map<String, Schema.SObjectField> configObjectFields = configObject.fields.getMap();
      //Check for Object and Field Access
      List<String> fieldNamesToCheckAccess = new List<String>();
      fieldNamesToCheckAccess.add('Name');
      fieldNamesToCheckAccess.add('Object__c');
      fieldNamesToCheckAccess.add('Relationship_Field__c');
      fieldNamesToCheckAccess.add('Detail_Field_1__c');
      fieldNamesToCheckAccess.add('Detail_Field_2__c');
      fieldNamesToCheckAccess.add('Detail_Field_3__c');
      fieldNamesToCheckAccess.add('Detail_Field_4__c');
      fieldNamesToCheckAccess.add('Detail_Field_5__c');
      fieldNamesToCheckAccess.add('Detail_Field_5__c');
      fieldNamesToCheckAccess.add('Visual_Type__c');
      fieldNamesToCheckAccess.add('Visual_Field__c');
      fieldNamesToCheckAccess.add('Search_Field__c');

      if (
        anyRecordHierarchy.isCreatable(
          fieldNamesToCheckAccess,
          configObject,
          configObjectFields
        )
      ) {
        Configuration__c arhObj1 = new Configuration__c();
        arhObj1.Name = 'ARH User Config';
        arhObj1.Object__c = 'User';
        arhObj1.Relationship_Field__c = 'ManagerId';
        arhObj1.Detail_Field_1__c = 'Name';
        arhObj1.Detail_Field_2__c = 'Title';
        arhObj1.Detail_Field_3__c = 'MobilePhone';
        arhObj1.Detail_Field_4__c = 'CompanyName';
        arhObj1.Detail_Field_5__c = 'SenderEmail';
        arhObj1.Visual_Type__c = 'Image';
        arhObj1.Visual_Field__c = 'MediumPhotoUrl';
        arhObj1.Search_Field__c = 'Name';
        insert arhObj1;

        Configuration__c arhObj2 = new Configuration__c();
        arhObj2.Name = 'ARH Asset Config';
        arhObj2.Object__c = 'Asset';
        arhObj2.Relationship_Field__c = 'ParentId';
        arhObj2.Detail_Field_1__c = 'Name';
        arhObj2.Detail_Field_2__c = 'SerialNumber';
        arhObj2.Detail_Field_3__c = 'Status';
        arhObj2.Detail_Field_4__c = 'UsageEndDate';
        arhObj2.Detail_Field_5__c = 'Quantity';
        arhObj2.Visual_Type__c = 'Abbreviation';
        arhObj2.Visual_Field__c = 'Name';
        arhObj2.Search_Field__c = 'Name';
        insert arhObj2;

        Configuration__c arhObj3 = new Configuration__c();
        arhObj3.Name = 'ARH Case Config';
        arhObj3.Object__c = 'Case';
        arhObj3.Relationship_Field__c = 'ParentId';
        arhObj3.Detail_Field_1__c = 'CaseNumber';
        arhObj3.Detail_Field_2__c = 'Subject';
        arhObj3.Detail_Field_3__c = 'Status';
        arhObj3.Detail_Field_4__c = 'Priority';
        arhObj3.Detail_Field_5__c = 'Origin';
        arhObj3.Visual_Type__c = 'Abbreviation';
        arhObj3.Visual_Field__c = 'Subject';
        arhObj3.Search_Field__c = 'CaseNumber';
        insert arhObj3;

        Configuration__c arhObj4 = new Configuration__c();
        arhObj4.Name = 'ARH Account Config';
        arhObj4.Object__c = 'Account';
        arhObj4.Relationship_Field__c = 'ParentId';
        arhObj4.Detail_Field_1__c = 'Name';
        arhObj4.Detail_Field_2__c = 'AccountNumber';
        arhObj4.Detail_Field_3__c = 'Type';
        arhObj4.Detail_Field_4__c = 'Phone';
        arhObj4.Detail_Field_5__c = 'Website';
        arhObj4.Visual_Type__c = 'Abbreviation';
        arhObj4.Visual_Field__c = 'Name';
        arhObj4.Search_Field__c = 'Name';
        insert arhObj4;

        User u = [SELECT Id, Email FROM User WHERE Id = :context.installerID()];
        String toAddress = u.Email;
        String[] toAddresses = new List<String>{ toAddress };
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(toAddresses);
        //mail.setReplyTo('syarlagadda@salesforce.com');
        mail.setSenderDisplayName('ARH Package Support');
        mail.setSubject('Package install successful');
        mail.setPlainTextBody('Thanks for installing the package.');
        Messaging.sendEmail(new List<Messaging.Email>{ mail });
      }
    }
  }
}
