/**
 * @description : Track stats for performance testing. Loosely based on .NET System.Diagnostics.Stopwatch
 *                Inspired by https://salesforce.stackexchange.com/questions/361731/is-it-more-efficient-to-use-a-map-and-call-get-or-use-a-set-and-call-contai/361741#361741
 *
 * @author      : erick@plancorp.com
 * @since       : 2022-05-15
 */

public class Stopwatch {
  private static final String DEFAULT_NAME = 'Stopwatch';

  String name;
  Boolean isRunning;
  DateTime startDT;
  Long totalTime;
  Integer startCPU;
  Integer totalCPU;
  Integer startCallouts;
  Integer totalCallouts;
  Long startHeap;
  Long totalHeap;

  public Stopwatch() {
    this(DEFAULT_NAME);
  }

  public Stopwatch(String s) {
    name = s;
    isRunning = false;
    totalTime = 0;
    totalCPU = 0;
    totalHeap = 0;
    totalCallouts = 0;
  }

  public void start() {
    if (!isRunning) {
      isRunning = true;
      startDT = DateTime.now();
      startCPU = Limits.getCpuTime();
      startHeap = Limits.getHeapSize();
      startCallouts = Limits.getCallouts();
    }
  }

  public void stop() {
    if (isRunning) {
      isRunning = false;
      totaltime += DateTime.now().getTime() - startDT.getTime();
      totalCPU += Limits.getCpuTime() - startCPU;
      totalHeap += Limits.getHeapSize() - startHeap;
      totalCallouts += Limits.getCallouts() - startCallouts;
    }
  }

  public void reset() {
    // Clear totals and start over
    totalTime = 0;
    totalCPU = 0;
    totalHeap = 0;
    totalCallouts = 0;
    if (isRunning) {
      startDT = DateTime.now();
      startCPU = Limits.getCpuTime();
      startHeap = Limits.getHeapSize();
      startCallouts = Limits.getCallouts();
    }
  }

  public Long getTime() {
    if (isRunning) {
      return totalTime + DateTime.now().getTime() - startDT.getTime();
    } else {
      return totalTime;
    }
  }

  public Long getCpuTime() {
    if (isRunning) {
      return totalCPU + Limits.getCpuTime() - startCPU;
    } else {
      return totalCPU;
    }
  }

  public Long getHeap() {
    if (isRunning) {
      return totalHeap + Limits.getHeapSize() - startHeap;
    } else {
      return totalHeap;
    }
  }

  public Long getCallouts() {
    if (isRunning) {
      return totalCallouts + Limits.getCallouts() - startCallouts;
    } else {
      return totalCallouts;
    }
  }

  public String getDebugString() {
    // Assemble log message with current totals
    return String.format(
      'Totals for {0}:\nClock Time elapsed: {1}\nCPU Time used: {2}\nHeap used: {3}\nCallouts: {4}',
      new List<String>{ name, String.valueOf(getTime()), String.valueOf(getCpuTime()), String.valueOf(getHeap()), String.valueOf(getCallouts()) }
    );
  }
}
