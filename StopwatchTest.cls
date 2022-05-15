@isTest
private class StopwatchTest {
  @TestSetup
  static void makeData() {
    Account a = new Account(Name = 'Test1');
    insert a;
  }

  @isTest
  static void testStartsAtZero() {
    Stopwatch sw = new Stopwatch('test1');
    System.assertEquals(0, sw.getTime(), 'Time on new Stopwatch should be 0');
    System.assertEquals(0, sw.getCpuTime(), 'CpuTime on new Stopwatch should be 0');
    System.assertEquals(0, sw.getHeap(), 'Heap on new Stopwatch should be 0');
    System.assertEquals(0, sw.getCallouts(), 'Callouts on new Stopwatch should be 0');
  }

  @isTest
  static void testBasicStartStop() {
    Stopwatch sw = new Stopwatch('test1');

    Test.startTest();
    sw.start();
    // Do something that should use a little CPU and memory
    List<Account> accounts = [SELECT Id, Name FROM Account];
    for (Account a : accounts) {
      System.debug(a);
    }
    sw.stop();
    Test.stopTest();

    System.assert(0 < sw.getTime(), 'Time on stopwatch should be greater than 0');
    System.assertEquals(0 < sw.getCpuTime(), 'CpuTime on stopwatch should be greater than 0');
    System.assertEquals(0 < sw.getHeap(), 'Heap on stopwatch should be greater than 0');
    // Could mock a callout to test getCallouts()
  }

  @isTest
  static void testGetsWhileRunning() {
    Stopwatch sw = new Stopwatch('test1');

    sw.start();
    // Do something that should use a little CPU and memory
    List<Account> accounts = [SELECT Id, Name FROM Account];
    for (Account a : accounts) {
      System.debug(a);
    }

    System.assert(0 < sw.getTime(), 'Time on stopwatch should be greater than 0');
    System.assertEquals(0 < sw.getCpuTime(), 'CpuTime on stopwatch should be greater than 0');
    System.assertEquals(0 < sw.getHeap(), 'Heap on stopwatch should be greater than 0');
    // Could mock a callout to test getCallouts()
  }

  @isTest
  static void testDebugString() {
    Stopwatch sw = new Stopwatch('test1');

    Test.startTest();
    sw.start();
    // Do something that should use a little CPU and memory
    List<Account> accounts = [SELECT Id, Name FROM Account];
    for (Account a : accounts) {
      System.debug(a);
    }
    sw.stop();
    Test.stopTest();

    String expected = 'Totals for test1:\n';
    String actual = sw.getDebugString();
    System.debug(actual);
    System.assert(actual.startsWith(expected), 'Debug string from stopwatch looks wrong');
  }

  @isTest
  static void testResetWhileRunning() {
    Stopwatch sw = new Stopwatch('test1');

    sw.start();
    // Do something that should use a little CPU and memory
    List<Account> accounts = [SELECT Id, Name FROM Account];
    for (Account a : accounts) {
      System.debug(a);
    }
    Integer beforeReset = sw.getCpuTime();
    sw.reset();
    Integer afterReset = sw.getCpuTime();

    System.debug(String.format('Before reset: {0}; After reset: {1}', new List<String>{ String.valueOf(beforeReset), String.valueOf(afterReset) }));
    // Can't really guarantee this, but not sure how else to check that it reset while running
    System.assert(beforeReset > afterReset, 'Stopwatch did not reset correctly');
  }

  @isTest
  static void testDefaultName() {
    Stopwatch sw = new Stopwatch();
    System.assert(sw.getDebugString().startsWith('Stopwatch'), 'Debug string from stopwatch default name looks wrong');
  }
}
