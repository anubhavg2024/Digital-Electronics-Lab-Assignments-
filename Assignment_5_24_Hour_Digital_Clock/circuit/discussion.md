# A5 - Discussion
The minutes counter advances when the seconds counter holds 59, and the hours counter advances only when both seconds and minutes hold 59. The carry output of each counter, high at its maximum value, provides this enable. Presetting the counters near the boundary made the rollover visible without waiting 24 hours. Counter values above the maximum (60 to 63, and 24 to 31) are unused.

During simulation, setting the clock frequency to 1 Hz allowed clear verification of individual state increments. The cascading logic gated by [HOUR_EN = C_SEC AND C_MIN] correctly prevented the hour counter from incrementing prematurely during intermediate minute rollovers.
