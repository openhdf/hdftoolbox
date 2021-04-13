from __future__ import absolute_import
from __future__ import print_function
import Screens.Standby
import timer
from time import localtime, mktime, time, strftime
from Components.config import config
from enigma import eDVBDB


debug = False
debug2 = False

class IPTVTimer(timer.Timer):
    def __init__(self):
        timer.Timer.__init__(self)

    def setRefreshTimer(self, tocall):
        # Add refresh Timer
        now = localtime()
        from .downloader import ConfigMenu
        from Tools.FuzzyDate import FuzzyTime
        if config.downloader.autoupdate_type.value == "auto":
            begin = mktime(
                (now.tm_year, now.tm_mon, now.tm_mday,
                config.downloader.autoupdate_time.value[0],
                config.downloader.autoupdate_time.value[1],
                0, now.tm_wday, now.tm_yday, now.tm_isdst)
            )

            if config.downloader.autoupdate_last.value < begin and begin < time():
                from .downloader import ConfigMenu
                ConfigMenu.createWaitTimer

            refreshTimer = IPTVTimerEntry(begin, tocall, nocheck=True)

            i = 0
            while i < 7:
                refreshTimer.setRepeated(i)
                i += 1

            self.addTimerEntry(refreshTimer)
            print("[IPTVTimer] Added Entry  ", self.timer_list[-1])



        if config.downloader.autoupdate_type.value == "periodic":
            import math
            i = 0
            k = int(config.downloader.autoupdate_timer.value)
            while i < 1440:
                begin = mktime(
                    (now.tm_year, now.tm_mon, now.tm_mday,
                    int(math.floor(i / 60)),
                    int(i % 60),
                    0, now.tm_wday, now.tm_yday, now.tm_isdst)
                )
                i += k
                
                if config.downloader.autoupdate_last.value < begin and begin < time():
                    ConfigMenu.createWaitTimer

                refreshTimer = IPTVTimerEntry(begin, tocall, nocheck=True)

                g = 0
                while g < 7:
                    refreshTimer.setRepeated(g)
                    g += 1

                self.addTimerEntry(refreshTimer)
                print("[IPTVTimer] Added Entry ", self.timer_list[-1])

    # just for debugging
    def show(self):
        for line in self.timer_list:
            print(line)

    def clear(self):
        self.timer_list = []

    def isActive(self):
        return len(self.timer_list) > 0

    def getNextTimerEntry(self):
        return self.timer_list[0]

class IPTVTimerEntry(timer.TimerEntry):
    """TimerEntry ..."""
    def __init__(self, begin, tocall, nocheck=False):
        timer.TimerEntry.__init__(self, int(begin), int(begin))

        self.function = tocall
        self.nocheck = nocheck
        if nocheck:
            self.state = self.StatePrepared

    def getNextActivation(self):
        # We delay our activation so we won't rush into reprocessing a repeating one
        return self.begin+1

    def activate(self):
        # check if Auto Update is enabled anyway
        if config.downloader.autoupdate.getValue():
            # Force the timer not to be exucuted more than one time
            self.state = self.StateRunning
            # check if we are in standby
            from Screens.Standby import inStandby
            if (not inStandby or config.downloader.autoupdate_runinstandby.getValue()):
                from . import downloader
                if downloader.doIptvUpdate():
                    config.downloader.autoupdate_last.value = int(time())
                    config.downloader.autoupdate_last.save()
                    eDVBDB.getInstance().reloadBouquets()
                    eDVBDB.getInstance().reloadServicelist()
                    return True
            #return True
        return True

    def timeChanged(self):
        if self.nocheck and self.state < self.StateRunning:
            self.state = self.StatePrepared

    def shouldSkip(self):
        return False

    def __repr__(self):
        return ''.join((
                "<IPTVTimerEntry (",
                ', '.join((
                    strftime("%c", localtime(self.begin)),
                    str(self.repeated),
                    str(self.function)
                )),
                ")>"
            ))

iptvtimer = IPTVTimer()
