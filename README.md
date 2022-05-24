# Stopwatch for Apex

Track stats for performance testing.

Loosely based on .NET `System.Diagnostics.Stopwatch`

Inspired by example at https://salesforce.stackexchange.com/questions/361731/is-it-more-efficient-to-use-a-map-and-call-get-or-use-a-set-and-call-contai/361741#361741

## Example usage
```java
Stopwatch swCallouts = new Stopwatch('Callouts');
swCallouts.start();
// Do some callouts
swCallouts.stop();
System.debug(swCallouts.getDebugString());
```


*Initial version by Erick Burtness 5/15/2022*