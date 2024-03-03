from __future__ import absolute_import
from __future__ import print_function
import os
from enigma import *
from Screens.Screen import Screen
from Screens.Standby import *
from Screens.MessageBox import MessageBox
from Screens.InputBox import InputBox, PinInput
from Screens.ChoiceBox import ChoiceBox
import Components.ParentalControl
from Components.ActionMap import ActionMap, NumberActionMap
from Components.config import config
from Components.ScrollLabel import ScrollLabel
from Components.GUIComponent import *
from Components.MenuList import MenuList
from Components.Input import Input
from Screens.Console import Console
from Screens.About import *
from Plugins.Plugin import PluginDescriptor
from RecordTimer import *
from time import *
from Tools import Directories, Notifications
import NavigationInstance
from .downloader import Hdf_Downloader
from boxbranding import getBoxType, getMachineBrand, getMachineName, getDriverDate, getImageVersion, getImageBuild, getBrandOEM, getImageType, getImageDistro, getOEVersion

toolboxversion = "Toolbox Version - 03.03.2024"

try:
    os.system("echo box_type=" + getBoxType() + " > /etc/image-version")
    os.system("echo build_type=" + getImageType() + " >> /etc/image-version")
    os.system("echo machine_brand=" + getMachineBrand() + " >> /etc/image-version")
    os.system("echo machine_name=" + getMachineName() + " >> /etc/image-version")
    os.system("echo version=" + getImageVersion() + " >> /etc/image-version")
    os.system("echo build=" + getImageBuild() + " >> /etc/image-version")
    os.system("echo imageversion=" + getImageVersion() + "-" + getImageBuild() + " >> /etc/image-version")
    os.system("echo date=`cat /etc/version`" + " >> /etc/image-version")
    os.system("echo comment=openHDF" " >> /etc/image-version")
    os.system("echo target=9" " >> /etc/image-version")
    os.system("echo creator=OpenHDF" " >> /etc/image-version")
    os.system("echo url=http://www.hdfreaks.cc" " >> /etc/image-version")
    os.system("echo catalog=http://www.hdfreaks.cc" " >> /etc/image-version")
    os.system("echo distro=" + getImageDistro() + " >> /etc/image-version")
    os.system("echo oeversion=" + getOEVersion() + " >> /etc/image-version")
    os.system("echo date=" + getImageBuild() + " >> /etc/image-version")
except:
    pass

try:
    os.system("echo ~~~ Box Info ~~~~~~~~~~~~~~~~~~~~"" > /tmp/.ImageVersion")
    os.system("echo getMachineName = " + getMachineName() + " >> /tmp/.ImageVersion")
    os.system("echo getMachineBrand = " + getMachineBrand() + " >> /tmp/.ImageVersion")
    os.system("echo getBoxType = " + getBoxType() + " >> /tmp/.ImageVersion")
    os.system("echo getBrandOEM = " + getBrandOEM() + " >> /tmp/.ImageVersion")
    os.system("echo getDriverDate = " + getDriverDate() + " >> /tmp/.ImageVersion")
    os.system("echo getImageVersion = " + getImageVersion() + " >> /tmp/.ImageVersion")
    os.system("echo getImageBuild = " + getImageBuild() + " >> /tmp/.ImageVersion")
    os.system("echo ~~~ CPU Info ~~~~~~~~~~~~~~~~~~~~"" >> /tmp/.ImageVersion")
    os.system("cat /proc/cpuinfo >> /tmp/.ImageVersion")
    os.system("/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts/autostart.sh")
except:
    pass


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

    def disable(self):
        self.HEADER = ''
        self.OKBLUE = ''
        self.OKGREEN = ''
        self.WARNING = ''
        self.FAIL = ''
        self.ENDC = ''


try:
    boxdesc = getMachineBrand() + " " + getMachineName()
    box = getBoxType()
except:
    boxdesc = "HDFreaks Toolbox"

try:
    #ET Boxen
    if getBoxType().startswith('et9'):
        box = "ET9x00"
    elif getBoxType().startswith('et6'):
        box = "ET6x00"
    elif getBoxType().startswith('et7'):
        box = "ET7x00"
    elif getBoxType().startswith('et5'):
        box = "ET5x00"
    elif getBoxType().startswith('et4'):
        box = "ET4x00"
    if getBoxType().startswith('et1'):
        box = "ET10000"
    if getBoxType().startswith('et8'):
        box = "ET8000"
    #VU Boxen
    elif getBoxType() == "vuduo":
        box = "Vu+Duo"
    elif getBoxType() == "vuduo2":
        box = "Vu+Duo2"
    elif getBoxType() == "vusolo":
        box = "Vu+Solo"
    elif getBoxType() == "vusolo2":
        box = "Vu+Solo2"
    elif getBoxType() == "vuzero":
        box = "Vu+Zero"
    #GigaBlues
    elif getBoxType().startswith('gb'):
        box = "GigaBlue"
    elif getBoxType() == "gbquad":
        box = "GigaBlue"
    elif getBoxType() == "gbquadplus":
        box = "GigaBlue"
    #Technomates
    elif getBoxType() == "tmtwin":
        box = "TM-Twin"
    #Ixussone
    elif getBoxType().lower().startswith('ixuss'):
        box = "Ixuss"
    #Maram/OdinM9
    elif getBoxType() == "odinm9":
        box = "OdinM9"
    elif getBoxType() == "odinm7":
        box = "OdinM7"
    elif getBoxType() == "odinm6":
        box = "OdinM6"
    #Dreambox
    elif getBoxType() == "dm800se":
        box = "Dreambox"
    #XP1000
    elif getBoxType().startswith('xp1000'):
        box = "XP1000"
    elif getBoxType().startswith == 'venton':
        box = "Venton"
    elif getBoxType() == "e3hd":
        box = "E3HD"
    elif getMachineBrand().startswith('GI'):
        box = "GI Xpeed LX"
    elif getBoxType() == 'axodin':
        box = "Opticum AX-Odin"
    elif getBoxType() == 'axase3':
        box = "Axas Class E3"
    elif getBoxType() == 'starsatlx':
        box = "Starsat LX"
    elif getBoxType() == 'classm':
        box = "Axas Class M"
    elif getBoxType() == 'xpeedlx3':
        box = "GI Xpeed LX3"
except:
    pass

## use another boxname for hdf-toolbox in mainmenu
try:
    if getMachineName() == 'STARSAT-LX':
        if os.path.exists("/etc/enigma2/.opticum") is True: #touch this file to show boxtye in toolbox
            box = "Opticum AX-Odin"
        else:
            box = "Starsat-LX"
    elif getMachineName().startswith('Golden'):
        box = "GI Xpeed LX"
    elif getBoxType() == 'xpeedlxcc':
        boxdesc = "GI XPEED LX CC"
    elif getBoxType() == 'xpeedlxcs2':
        boxdesc = "GI XPEED LX CS2"
    elif getMachineName() == 'SF8 HD':
        boxdesc = "SF8 HD"
    elif getBoxType() == 'twinboxlcd':
        boxdesc = "RE TWINBOX LCD"
    elif getBoxType() == 'Ixuss One':
        boxdesc = "Ixuss One"
        getMachineName = "Ixuss On"
    elif getBoxType() == 'Ixuss Zero':
        boxdesc = "Ixuss Zero"
        getMachineName = "Ixuss Zero"
    elif getBoxType().startswith('optimuss'):
        boxdesc = "Edision Optimuss"
except:
    pass

## read .brand and .machine for other OEMs
brandfile = "/etc/.brand"
if os.path.exists(brandfile) is True:
    brand = open(brandfile, "r")
    box = brand.readline().lower()
    brand.close()

machinefile = "/etc/.machine"
if os.path.exists(machinefile) is True:
    machine = open(machinefile, "r")
    boxmachine = machine.readline().lower()
    machine.close()

#change some names that are reading in .brand file
if box == 'opticum':
    box = "Opticum AX-Odin"

os.system("chmod 755 -R /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox")

# remove some unwanted entries in menu files
#if not getBoxType().startswith('et'):
#    os.system("find /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/menu/tools.cfg -type f -exec sed -i '/HbbTV/d' {} \;")
if not getBoxType().startswith('gb'):
    os.system("find /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/menu/fixes.cfg -type f -exec sed -i '/fix_gb_display/d' {} \;")

# plugin calling support comes here ...
pluginpath = "/usr/lib/enigma2/python/Plugins/"

#create symlinks for SystemPlugins and Extensions
if not os.path.exists("/Extensions"):
    if os.path.islink("/usr/lib/enigma2"):
        src = '/usr/lib64/enigma2/python/Plugins/Extensions'
    else:
        src = '/usr/lib/enigma2/python/Plugins/Extensions'
    dst = '/Extensions'
    os.symlink(src, dst)

if not os.path.exists("/SystemPlugins"):
    if os.path.islink("/usr/lib/enigma2"):
        src = '/usr/lib64/enigma2/python/Plugins/SystemPlugins'
    else:
        src = '/usr/lib/enigma2/python/Plugins/SystemPlugins'
    dst = '/SystemPlugins'
    os.symlink(src, dst)

from Screens.Ci import *
from Screens.PluginBrowser import *
from Screens.SkinSelector import SkinSelector
from Plugins.SystemPlugins.SoftwareManager.plugin import *

# SoftcamManager
if os.path.exists("%s/Extensions/SoftcamManager" % pluginpath) is True:
   from Plugins.Extensions.SoftcamManager.Sc import *
if os.path.exists("/usr/lib/enigma2/python/Plugins/PLi/SoftcamSetup") is True:
   from Plugins.PLi.SoftcamSetup.Sc import *
if os.path.exists("/usr/lib/enigma2/python/Plugins/SystemPlugins/SoftcamSetup") is True:
   from Plugins.SystemPlugins.SoftcamSetup.Sc import *
if os.path.exists("/usr/lib/enigma2/python/Screens/SoftcamSetup.py") is True:
    from Screens.SoftcamSetup import SoftcamSetup

# starting cardserver and softcam
if os.path.exists("/etc/init.d/cardserver") is True:
   os.system("/etc/init.d/cardserver restart &")
if os.path.exists("/etc/init.d/softcam") is True:
   os.system("/etc/init.d/softcam restart &")

fantastic_pluginversion = "Version 0.1.2 .. HDF mod"
fantastic_pluginpath = "/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox"
fantastic_readme = "/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/readme.txt"
splitchar = ":"

session = None


def autostart(reason, **kwargs):
    global session
    if reason == 0 and "session" in kwargs:
       session = kwargs["session"]
       session.open(FantasticBoot)


def iptvUpdate(reason, **kwargs):
    if config.downloader.autoupdate.value:
        print("[HDF-Toolbox]: IPTV autoupdate")
        global session
        if reason == 0:
             from . import downloader
             from .downloader import iptvtimer, ConfigMenu
             downloader.doIptvUpdate()
             iptvtimer.setRefreshTimer(ConfigMenu.createWaitTimer)


def menu(menuid, **kwargs):
    if menuid == "mainmenu":
        return [(_("HDF Toolbox " + boxdesc + ""), main, "hdf_toolbox", 10)]
    return []


def Plugins(**kwargs):
    try:
        return [PluginDescriptor(where=[PluginDescriptor.WHERE_SESSIONSTART, PluginDescriptor.WHERE_AUTOSTART], fnc=autostart),
                PluginDescriptor(where=PluginDescriptor.WHERE_AUTOSTART, fnc=iptvUpdate),
                PluginDescriptor(name=" HDF Toolbox " + boxdesc + "", description="Addons, Scripts, Tools", where=PluginDescriptor.WHERE_EXTENSIONSMENU, icon="hdf.png", fnc=main),
                PluginDescriptor(name="HDF Toolbox " + boxdesc + "", description="Addons, Scripts, Tools", where=PluginDescriptor.WHERE_MENU, fnc=menu),
                PluginDescriptor(where=PluginDescriptor.WHERE_FILESCAN, fnc=filescan)]
    except:
        return [PluginDescriptor(where=[PluginDescriptor.WHERE_SESSIONSTART, PluginDescriptor.WHERE_AUTOSTART], fnc=autostart), PluginDescriptor(name="HDFreaks Toolbox " + boxdesc + "", description="Addons, Scripts, Tools", where=[PluginDescriptor.WHERE_PLUGINMENU, PluginDescriptor.WHERE_EXTENSIONSMENU], icon="hdf.png", fnc=main), PluginDescriptor(name="HDFreaks Toolbox " + boxdesc + "", description="Addons, Scripts, Tools", where=PluginDescriptor.WHERE_MENU, fnc=menu)]


def main(session, **kwargs):
    try:
        session.open(Fantastic)
    except:
        print("[FANTASTIC] Pluginexecution failed")


class Fantastic(Screen):
    skin = """
        <screen position="150,150" size="360,395" title="HDF Toolbox">
        <widget name="menu" position="10,10" size="340,340" scrollbarMode="showOnDemand" enableWrapAround="1" />
            <ePixmap position="10,335" size="380,57" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/banner.png" zPosition="1" alphatest="on" />
        </screen>"""

    def __init__(self, session, args=0):
        self.skin = Fantastic.skin
        self.session = session
        Screen.__init__(self, session)
        self.menu = args
        self.protectContextMenu = True

        if self.isProtected():
           self.onFirstExecBegin.append(boundFunction(self.session.openWithCallback, self.protectResult, PinInput, pinList=[x.value for x in config.ParentalControl.servicepin], triesEntry=config.ParentalControl.retries.servicepin, title=_("Please enter the correct pin code"), windowTitle=_("Enter pin code")))

        global mfcommand
        global mfmenu
        global mfmenuold
        global mfexecute
        global mfmenudescr
        global mfintargument
        global mftextargument

        try:
           if mfmenu is None:
              pass
        except:
           mfmenu = "main"
           mfmenuold = "main"
           mfmenudescr = "Menu Fantastic Main Menu"

        if mfmenu == "red":
           pass
        elif mfmenu == "green":
           pass
        elif mfmenu == "yellow":
           pass
        elif mfmenu == "blue":
           pass
        else:
           mfmenu = "main"
           mfmenuold = "main"
           mfmenudescr = "Menu Fantastic Main Menu"

        mfexecute = " "
        mfintargument = 0
        mftextargument = " "

        mainmenu = []

        menufile = "%s/%s.cfg" % (fantastic_pluginpath, mfmenu)
        if os.path.exists(menufile) is True:
           mf = open(menufile, "r")
           for line in mf:
              parts = line.split(splitchar, 3)
              index = len(parts)

              if index > 1:
                 command = parts[0].upper().rstrip()
                 mfcommand = command[0]
                 if mfcommand != "S":
                    if index > 2:
                       mainmenu.append((str(parts[2]), line))
                    else:
                       mainmenu.append((str(parts[1]), line))

           mf.close()
        else:
           mainmenu.append(("no %s.cfg found - please reboot" % mfmenu, "mfnomenu"))

        # SoftcamManager
        if os.path.exists("%s/Extensions/SoftcamManager" % pluginpath) is True:
           mainmenu.append(("Softcam Cardserver Manager", "mfsc"))
        elif os.path.exists("/usr/lib/enigma2/python/Plugins/PLi/SoftcamSetup") is True:
           mainmenu.append(("Softcam Cardserver Manager", "mfsc"))
        elif os.path.exists("/usr/lib/enigma2/python/Plugins/SystemPlugins/SoftcamSetup") is True:
           mainmenu.append(("Image Softcam Cardserver Manager", "mfsc"))
        elif os.path.exists("/usr/lib/enigma2/python/Screens/SoftcamSetup.py") is True:
           mainmenu.append(("Image Softcam Cardserver Manager", "mfsc2"))
        else:
            pass

        if os.path.exists("/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/downloader.pyc") or os.path.exists("/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/downloader.pyo"):
           mainmenu.append(("openHDF-Downloader", "mfschdf"))

        mainmenu.append(("--------------------------------------------------", "mfxyz"))
        mainmenu.append((toolboxversion, "mfxyz"))
        mainmenu.append(("About", "mfabout"))

        self["menu"] = MenuList(mainmenu)
        self["actions"] = ActionMap(["WizardActions", "DirectionActions"], {"ok": self.FantasticMainMenu, "back": self.close, }, -1)

    def isProtected(self):
        return self.protectContextMenu and config.ParentalControl.setuppinactive.value and config.ParentalControl.config_sections.hdftoolbox.value

    def protectResult(self, answer):
        if answer:
            self.protectContextMenu = False
        elif answer is not None:
            self.session.openWithCallback(self.close, MessageBox, _("The pin code you entered is wrong."), MessageBox.TYPE_ERROR)
        else:
            self.close()

    def FantasticMainMenu(self):

        global mfcommand
        global mfmenu
        global mfmenuold
        global mfexecute
        global mfmenudescr
        global mfintargument
        global mftextargument

        mfselected = self["menu"].l.getCurrentSelection()[1]

        if mfselected is not None:
           if mfselected == "mfreadme":
                self.session.open(Console, _("Showing Fantastic readme.txt"), ["cat %s" % fantastic_readme])
           elif mfselected == "mfnomenu":
               title1 = _("HDF-Toolbox")
               title2 = _("needs a %s.cfg file at" % mfmenu)
               title3 = _("%s" % fantastic_pluginpath)
               title = "%s\n%s\n%s" % (title1, title2, title3)
               self.session.open(MessageBox, ("%s") % (title), MessageBox.TYPE_INFO)
           elif mfselected == "mfabout":
               title1 = _("Menu Fantastic Plugin %s") % fantastic_pluginversion
               title2 = _("by gutemine is Freeware - use at your own risk !")
               title3 = _("~~~~~~~~~~~~~~~~~~~~~~~~~")
               title4 = _("adapted by www.hdfreaks.cc")
               title = "%s\n%s\n%s\n%s" % (title1, title2, title3, title4)
               self.session.open(MessageBox, ("%s") % (title), MessageBox.TYPE_INFO)
           elif mfselected == "mfschdf":
               try:
                   self.session.open(Hdf_Downloader)
               except:
                    self.session.open(MessageBox, ("There seems to be an Error!\nPlease check if your internet connection is established correctly."), MessageBox.TYPE_INFO, timeout=10).setTitle(_("HDFreaks.cc Downloader Error"))
           elif mfselected == "mfsc":
               self.session.openWithCallback(self.FantasticMenu(""), ScSelection)
           elif mfselected == "mfsc2":
               self.session.openWithCallback(self.FantasticMenu(""), SoftcamSetup)
           elif mfselected == "mfxyz":
               title1 = _("HDF Toolbox")
               title2 = _("~~~~~~~~~~~~~~~~")
               title3 = _("visit www.HDFreaks.cc for updates and support")
               title = "%s\n%s\n%s\n" % (title1, title2, title3)
               self.session.open(MessageBox, ("%s") % (title), MessageBox.TYPE_INFO)
           else:
               self.FantasticMenuSelected(mfselected)

    def FantasticMenu(self, status):

        global mfcommand
        global mfmenu
        global mfmenuold
        global mfexecute
        global mfmenudescr
        global mfintargument
        global mftextargument

        if mfmenu is None:
           self.skipMF("No menu passed, returning")
        else:
           mfmenufile = "%s/%s.cfg" % (fantastic_pluginpath, mfmenu.rstrip())
           if os.path.exists(mfmenufile) is True:
              mf = open(mfmenufile, "r")
              line = mf.readline()
              mf.close()
              parts = line.split(splitchar, 3)
              index = len(parts)
              if index > 1:
                 command = parts[0].upper().rstrip()
                 # only if menu file contains S in first line startup is executed
                 if command[0] == "S":
                    if index > 3:
                       cmd = parts[3].rstrip()
                       if mfmenu == mfmenuold:
                          pass
                       elif mfmenu == "main":
                          pass
                       else:
                          if os.path.exists("%s/%s" % (fantastic_pluginpath, cmd)) is True:
                             os.system("%s/%s %s" % (fantastic_pluginpath, cmd, mftextargument))
                          else:
                             os.system("%s %s" % (cmd, mftextargument))

                       mfmenudescr = parts[2].rstrip()
                    else:
                       if index == 3:
                          mfmenudescr = parts[2].rstrip()
                       else:
                          mfmenudescr = parts[1].rstrip()

           if os.path.exists("%s/%s.cfg" % (fantastic_pluginpath, mfmenu.rstrip())) is True:
              if mfmenu == "main":
                 pass
              else:
                 self.session.openWithCallback(self.FantasticMenuSelected, ChoiceBox, mfmenudescr, self.ListMenuFantastic())
           else:
              self.skipMF("no Menufile %s.cfg" % mfmenu)

    def FantasticMenuSelected(self, mfselected):

        global mfcommand
        global mfmenu
        global mfmenuold
        global mfexecute
        global mfmenudescr
        global mfintargument
        global mftextargument

        if mfselected is None:
#           self.skipMF("nothing selected")
           mfmenu = "main"
        else:
           try:
              parts = mfselected.split(splitchar, 4)
           except:
              parts = mfselected[1].split(splitchar, 4)

           mfcommand = " "
           mfexecute = " "
           mfintargument = 0
           mftextargument = " "

           index = len(parts)
           if index > 1:
              command = parts[0].upper().rstrip()
              mfcommand = command[0]
           else:
              command = " "
              mfcommand = command[0]

           if index > 1:
              mfmenuold = mfmenu
              mfmenu = parts[1].rstrip()

           if index > 2:
              mfmenudescr = parts[2].rstrip()
           else:
              mfmenudescr = parts[1].rstrip()

           if index > 3:
              mfexecute = parts[3].rstrip()
              mftextargument = parts[3].rstrip()

           if index > 4:
              mftextargument = parts[4].rstrip()
              try:
                 mfintargument = int(mftextargument)
              except:
                 mfintargument = 0
           elif index == 4:
              mftextargument = parts[3].rstrip()
              try:
                 mfintargument = int(mftextargument)
              except:
                 mfintargument = 0
           else:
              pass

           if mfcommand == "E":
              if os.path.exists("%s/%s" % (fantastic_pluginpath, mfexecute)) is True:
                 os.system("%s/%s %s" % (fantastic_pluginpath, mfexecute, mftextargument))
              else:
                 os.system("%s %s" % (mfexecute, mftextargument))
              self.session.openWithCallback(self.FantasticMenu, MessageBox, "%s %s was executed !" % (mfexecute, mftextargument), MessageBox.TYPE_INFO, timeout=mfintargument)
           elif mfcommand == "U":
              if os.path.exists("%s/%s" % (fantastic_pluginpath, mfexecute)) is True:
                 os.system("%s/%s %s" % (fantastic_pluginpath, mfexecute, mftextargument))
              else:
                 os.system("%s %s" % (mfexecute, mftextargument))
              self.FantasticMenu("")
           elif mfcommand == "C":
              if os.path.exists("%s/%s" % (fantastic_pluginpath, mfexecute)) is True:
                 self.session.openWithCallback(self.FantasticMenu(""), Console, _("Executing %s %s" % (mfexecute, mftextargument)), ["%s/%s %s" % (fantastic_pluginpath, mfexecute, mftextargument)])
              else:
                 self.session.openWithCallback(self.FantasticMenu(""), Console, _("Executing %s %s" % (mfexecute, mftextargument)), ["%s %s" % (mfexecute, mftextargument)])
           elif mfcommand == "A":
              FantasticApplication(self.session)
              self.FantasticMenu("")
           elif mfcommand == "P":
              plugininstalled = False
              if os.path.exists("%s/Extensions/%s" % (pluginpath, mftextargument)) is True:
                 plugininstalled = True
              if os.path.exists("%s/SystemPlugins/%s" % (pluginpath, mftextargument)) is True:
                 plugininstalled = True

              if plugininstalled is True:
                 if mftextargument == "Tuxtxt":
                    self.session.openWithCallback(self.FantasticMenu(""), ScSelection)
                 elif mftextargument == "SoftcamManager":
                    self.session.openWithCallback(self.FantasticMenu(""), ScSelection)
                 elif mftextargument == "BarryAllen":
                    self.session.openWithCallback(self.FantasticMenu(""), BarryAllenPlugin)
                 elif mftextargument == "Multiboot":
                    self.session.openWithCallback(self.FantasticMenu(""), Multiboot)
                 elif mftextargument == "MediaPlayerDeluxe":
                    self.session.openWithCallback(self.FantasticMenu(""), MediaPlayerDeluxe)
                 elif mftextargument == "SpiderFan":
                    self.session.openWithCallback(self.FantasticMenu(""), SpiderFan)
                 elif mftextargument == "Elektro":
                    self.session.openWithCallback(self.FantasticMenu(""), Elektro)
                 elif mftextargument == "Diabolius":
                    self.session.openWithCallback(self.FantasticMenu(""), Diabolius)
                 elif mftextargument == "Sakrileg":
                    self.session.openWithCallback(self.FantasticMenu(""), Sakrileg)
                 elif mftextargument == "Shell":
                    self.session.openWithCallback(self.FantasticMenu(""), Shell)
                 elif mftextargument == "Telefonbuch":
                    self.session.openWithCallback(self.FantasticMenu(""), Telefonbuch)
                 elif mftextargument == "PicturePlayer":
                    self.session.openWithCallback(self.FantasticMenu(""), picmain)
                 elif mftextargument == "ConfigurationBackup":
                    try:
                       self.session.openWithCallback(self.FantasticMenu(""), BackupSetup)
                    except:
                       pass
                 elif mftextargument == "GboxSuite":
                    try:
                       self.session.openWithCallback(self.FantasticMenu(""), GboxSuite)
                    except:
                       pass
                 elif mftextargument == "KeyUpdater":
                    try:
                       self.session.openWithCallback(self.FantasticMenu(""), KeyUpdater)
                    except:
                       pass
                 elif mftextargument == "CCcamInfo":
                    try:
                       self.session.openWithCallback(self.FantasticMenu(""), CCcamInfo)
                    except:
                       pass
                 elif mftextargument == "LasMail":
                    self.session.openWithCallback(self.FantasticMenu(""), LasMail)
                 elif mftextargument == "Tuxcom":
                    self.session.openWithCallback(self.FantasticMenu(""), TuxComStarter)
                 elif mftextargument == "Cronmanager":
                    self.session.openWithCallback(self.FantasticMenu(""), Cronmanager)
                 elif mftextargument == "TuxboxGames":
                    self.session.openWithCallback(self.FantasticMenu(""), GameStarter)
                 elif mftextargument == "FrontprocessorUpgrade":
                    self.session.openWithCallback(self.FantasticMenu(""), FPUpgrade)
                 elif mftextargument == "ImageUpdate":
                    try:
                       self.session.openWithCallback(self.FantasticMenu(""), ImageUpdate)
                    except:
                       pass
                 elif mftextargument == "weinbergtagger":
                    self.session.openWithCallback(self.FantasticMenu(""), weinbergtagger)
                 elif mftextargument == "SkinSelector":
                    try:
                       self.session.openWithCallback(self.FantasticMenu(""), SkinSelector)
                    except:
                       self.session.openWithCallback(self.FantasticMenu, MessageBox, "Plugin %s is not wrapped !" % mftextargument, MessageBox.TYPE_INFO)
                 else:
                    self.session.openWithCallback(self.FantasticMenu, MessageBox, "Plugin %s is not wrapped !" % mftextargument, MessageBox.TYPE_INFO)
              else:
                 if mftextargument == "Ci":
                    self.session.openWithCallback(self.FantasticMenu(""), CiSelection)
                 elif mftextargument == "BP":
                    if os.path.exists("/usr/lib/enigma2/python/Bp") is True:
                       try:
                          self.session.openWithCallback(self.FantasticMenu(""), BPmenu)
                       except:
                          self.session.openWithCallback(self.FantasticMenu(""), BP_Menu)
                    else:
                       self.session.openWithCallback(self.FantasticMenu, MessageBox, "Plugin %s is not available !" % mftextargument, MessageBox.TYPE_INFO)
                 else:
                    self.session.openWithCallback(self.FantasticMenu, MessageBox, "Plugin %s is not installed !" % mftextargument, MessageBox.TYPE_INFO)

           elif mfcommand == "R":
              if mfintargument == 3:
                 self.session.openWithCallback(self.FantasticMenu, MessageBox, "Restarting Enigma2", MessageBox.TYPE_INFO, timeout=5)
                 TryQuitMainloop(self.session, mfintargument)
              elif mfintargument == 2:
                 self.session.openWithCallback(self.FantasticMenu, MessageBox, "Restarting Dreambox", MessageBox.TYPE_INFO, timeout=5)
                 TryQuitMainloop(self.session, mfintargument)
              elif mfintargument == 1:
                 self.session.openWithCallback(self.FantasticMenu, MessageBox, "Entering Deepstandby", MessageBox.TYPE_INFO, timeout=5)
                 TryQuitMainloop(self.session, mfintargument)
              else:
                 pass
           elif mfcommand == "I":
              if os.path.exists("%s/%s.txt" % (fantastic_pluginpath, mfexecute)) is True:
                 menufile = "%s/%s.txt" % (fantastic_pluginpath, mfexecute)
                 mf = open(menufile, "r")
                 mfexecute = mf.readline()
                 mf.close()
                 self.session.openWithCallback(self.FantasticMenu, MessageBox, mfexecute, MessageBox.TYPE_INFO, timeout=mfintargument)
              elif os.path.exists("/tmp/%s.txt" % (mfexecute)) is True:
                 menufile = "/tmp/%s.txt" % (mfexecute)
                 mf = open(menufile, "r")
                 mfexecute = mf.readline()
                 mf.close()
                 self.session.openWithCallback(self.FantasticMenu, MessageBox, mfexecute, MessageBox.TYPE_INFO, timeout=mfintargument)
              else:
                 self.session.openWithCallback(self.FantasticMenu, MessageBox, mfexecute, MessageBox.TYPE_INFO, timeout=mfintargument)

# modded by koivo G: read file
           elif mfcommand == "G":
              if os.path.exists("%s" % (mfexecute)) is True:
                 os.system("%s %s" % (mfexecute, mftextargument))
                 datei = open(mftextargument, "r")
                 Ausgabe = datei.read()
                 datei.close()
                 self.session.openWithCallback(self.FantasticMenu, MessageBox, Ausgabe, MessageBox.TYPE_INFO)
# modded by koivo Q: execute and read file
           elif mfcommand == "Q":
                 os.system("%s>%s" % (mfexecute, mftextargument))
                 datei = open(mftextargument, "r")
                 Ausgabe = datei.read(400)
                 datei.close()
                 self.session.openWithCallback(self.FantasticMenu, MessageBox, Ausgabe, MessageBox.TYPE_INFO, timeout=mfintargument)
# modded by koivo Q: execute and read file with yes or no
           elif mfcommand == "X":
                 os.system("%s>%s" % (mfexecute, mftextargument))
                 datei = open(mftextargument, "r")
                 Ausgabe = datei.read()
                 datei.close()
                 self.session.openWithCallback(self.FantasticYN, MessageBox, Ausgabe, MessageBox.TYPE_YESNO)
# modded by koivo Z: open extra plugins and screens
           elif mfcommand == "Z":
                 self.session.openWithCallback(self.FantasticMenu(""), PluginBrowser)
# modded by henrylicious W: open extra plugins and screens
           elif mfcommand == "W":
                 self.session.openWithCallback(self.FantasticMenu(""), SkinSelector)
           elif mfcommand == "1":
                 #os.system("opkg update")
                 self.session.openWithCallback(self.FantasticMenu(""), UpdatePluginMenu)
           elif mfcommand == "D":
              self.session.openWithCallback(self.FantasticMenu(""), FantasticLCD, mftextargument)
           elif mfcommand == "L":
              if mftextargument == "log":
                 os.system("echo %s > /tmp/fantasticlog.txt" % mfexecute)
              elif mftextargument == "logappend":
                 os.system("echo %s >> /tmp/fantasticlog.txt" % mfexecute)
              elif mftextargument == "reset":
                 if os.path.exists("/tmp/fantasticlog.txt") is True:
                    os.system("rm /tmp/fantasticlog.txt")
              elif mftextargument == "wall":
                 os.system("wall %s" % mfexecute)
              else:
                 print("[FANTASTIC] Logging: %s" % mfexecute)
              self.FantasticMenu("")
           elif mfcommand == "M":
              self.FantasticMenu("")
           elif mfcommand == "T":
              self.session.openWithCallback(self.FantasticEnterText, InputBox, title=mfmenudescr, text=mftextargument, maxSize=False, type=Input.TEXT)
           elif mfcommand == "Y":
              self.session.openWithCallback(self.FantasticYN, MessageBox, mfmenudescr, MessageBox.TYPE_YESNO)
           else:
              pass

    def ListMenuFantastic(self):

        global mfcommand
        global mfmenu
        global mfmenuold
        global mfexecute
        global mfmenudescr
        global mfintargument
        global mftextargument

        menu = []

        menufile = "%s/%s.cfg" % (fantastic_pluginpath, mfmenu)
        mf = open(menufile, "r")

        for line in mf:
           parts = line.split(splitchar, 3)
           index = len(parts)
           if index > 1:
              command = parts[0].upper().rstrip()
              if command[0] != "S":
                 if index > 2:
                    menu.append((str(parts[2]), line))
                 else:
                    menu.append((str(parts[1]), line))
        mf.close()

        return menu

    def FantasticEnterText(self, mftext):

        global mfcommand
        global mfmenu
        global mfmenuold
        global mfexecute
        global mfmenudescr
        global mfintargument
        global mftextargument

        if mftext is None:
           mftextargument = None
           mfmenu = "main"
           self.skipMF("No text passed, Exiting menu %s" % mfmenu)
        else:
           mftextargument = mftext
           self.FantasticMenu("")

    def FantasticYN(self, mfanswer):

        global mfcommand
        global mfmenu
        global mfmenuold
        global mfexecute
        global mfmenudescr
        global mfintargument
        global mftextargument

        if mfanswer is False:
           if mftextargument is not None:
              if mftextargument != " ":
                 mfmenu = mftextargument

        self.FantasticMenu("")

    def skipMF(self, reason):
        self.session.open(MessageBox, _("Menu Fantastic exits, because %s") % reason, MessageBox.TYPE_WARNING)


class FantasticButton(Screen):
    def __init__(self, session, button):
        Screen.__init__(self, session)
        self.session = session

        global mfcommand
        global mfmenu
        global mfmenuold
        global mfexecute
        global mfmenudescr
        global mfintargument
        global mftextargument

        if button is not None:
           mfmenuold = button
           mfmenu = button
           mfmenudescr = "Menu Fantastic %s Button Menu" % button
        else:
           mfmenuold = "main"
           mfmenu = "main"
           mfmenudescr = "Menu Fantastic Main Menu"


class FantasticBoot(Screen):
    skin = """
        <screen position="100,100" size="500,400" title="HDFreaks.cc" >
        </screen>"""

    def __init__(self, session):
        self.skin = FantasticBoot.skin
        Screen.__init__(self, session)
        self.session = session

        mainmenufile = "%s/%s.cfg" % (fantastic_pluginpath, "main")
        if os.path.exists(mainmenufile) is True:
           mfmain = open(mainmenufile, "r")
           line = mfmain.readline()
           parts = line.split(splitchar, 3)
           index = len(parts)
           if index > 1:
              command = parts[0].upper().rstrip()
              # only if menu file contains S in first line startup is executed
              if command[0] == "S":
                 if index > 3:
                    cmd = parts[3].rstrip()
                    if os.path.exists("%s/%s" % (fantastic_pluginpath, cmd)) is True:
                       os.system("%s/%s" % (fantastic_pluginpath, cmd))
                    else:
                       os.system("%s" % (cmd))

                 mfmain.close()


class FantasticApplication(Screen):

    def __init__(self, session):
        self.session = session
        self.skin = Fantastic.skin
        Screen.__init__(self, session)
        self.container = eConsoleAppContainer()
        self.container.appClosed.get().append(self.finished)
        self.runapp()

    def runapp(self):

        global mfcommand
        global mfmenu
        global mfmenuold
        global mfexecute
        global mfmenudescr
        global mfintargument
        global mftextargument

        eDBoxLCD.getInstance().lock()
        eRCInput.getInstance().lock()
        fbClass.getInstance().lock()
        self.session.nav.stopService()
        if os.path.exists(mfexecute) is True:
           self.container.execute("%s %s" % (mfexecute, mftextargument))
        else:
           self.container.execute("%s/%s %s" % (fantastic_pluginpath, mfexecute, mftextargument))

    def finished(self, retval):
        fbClass.getInstance().unlock()
        eRCInput.getInstance().unlock()
        eDBoxLCD.getInstance().unlock()
        self.session.nav.playService(eServiceReference(config.tv.lastservice.value))


class FantasticLCD(Screen):
    # use size 0,0 to show text on LCD only
    skin = """
        <screen position="0,0" size="0,0" title="LCD Text" >
            <widget name="text" position="0,0" size="0,0" font="Regular;14" halign="center"/>
        </screen>"""

    def __init__(self, session, title="LCD Text"):
        self.skin = FantasticLCD.skin
        Screen.__init__(self, session)

        self["text"] = Label("")

        # minimal actions to be able to exit after showing LCD Label
        self["actions"] = ActionMap(["WizardActions", "DirectionActions"],
        {
                "ok": self.cancel,
                "back": self.cancel,
        }, -1)
        # now set passed Text Label for LCD output
        self.newtitle = title
        self.onShown.append(self.updateTitle)

    def updateTitle(self):
        self.setTitle(self.newtitle)

    def cancel(self):
        self.close()
