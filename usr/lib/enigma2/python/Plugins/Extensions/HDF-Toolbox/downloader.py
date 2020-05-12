from Components.AVSwitch import AVSwitch
from Components.ActionMap import ActionMap, NumberActionMap
from Components.Label import Label
from Components.MenuList import MenuList
from Components.Pixmap import Pixmap
from Components.ProgressBar import ProgressBar
from Components.Sources.StaticText import StaticText
from Screens.Console import Console
from Plugins.Plugin import PluginDescriptor
from Components.PluginComponent import plugins
from Components.PluginList import *
from Components.config import config, ConfigSubsection, ConfigYesNo, getConfigListEntry, configfile, ConfigText
from Components.ConfigList import ConfigListScreen
from Tools.Directories import resolveFilename, SCOPE_PLUGINS, SCOPE_SKIN_IMAGE
from Screens.MessageBox import MessageBox
from Screens.Screen import Screen
from Screens.Standby import TryQuitMainloop
from Tools.Downloader import downloadWithProgress
from enigma import ePicLoad, eTimer, eDVBDB
from twisted.web.client import downloadPage
from time import localtime, mktime, time, strftime
import os
import sys
import glob
from boxbranding import getBoxType, getMachineBrand, getMachineName, getDriverDate, getImageVersion, getImageBuild, getBrandOEM
from IPTVTimer import iptvtimer, IPTVTimerEntry

box = getBoxType()
boxname = getBoxType()

try:
    #ET Boxen
    if getBoxType().startswith('et9'):
        box = "et9000"
        boxname = "ET9x00"
    elif getBoxType().startswith('et7'):
        box = "et9000"
        boxname = "ET7x00"
    elif getBoxType().startswith('et6'):
        box = "et9000"
        boxname = "ET6x00"
    elif getBoxType().startswith('et5'):
        box = "et9000"
        boxname = "ET5x00"
    elif getBoxType().startswith('et4'):
        box = "et9000"
        boxname = "ET4x00"
    if getBoxType().startswith('et8'):
        box = "et9000"
        boxname = "ET8000"
    if getBoxType().startswith('et1'):
        box = "et9000"
        boxname = "ET10000"
    #VU Boxen
    elif getBoxType() == "vuduo":
        box = "vuduo"
        boxname = "VU+Duo"
    elif getBoxType() == "vuzero":
        box = "vuduo"
        boxname = "VU+Zero"
    elif getBoxType() == "vuduo2":
        box = "vuduo"
        boxname = "VU+Duo2"
    elif getBoxType() == "vusolo":
        box = "vusolo"
        boxname = "VU+Solo"
    elif getBoxType() == "vusolo2":
        box = "vusolo"
        boxname = "VU+Solo2"
    #GigaBlues
#    elif getBoxType().startswith('gb'):
#        box = "gigablue"
#        boxname = "GigaBlue"
    elif getBoxType() == "gbquad":
        box = "gbquad"
        boxname = "GigaBlue"
    elif getBoxType() == "gbquad4k":
        box = "gbquad4k"
        boxname = "GB UHD QUAD 4K"
	#Technomates
    elif getBoxType() == "tmtwin":
        box = "tmtwin"
        boxname = "TM-Twin"
    elif getBoxType() == "tm2t":
        box = "tmtwin"
        boxname = "TM-2T"
    elif getBoxType() == "tmsingle":
        box = "tmtwin"
        boxname = "TM-Single"
    #Ixussone
    elif getBoxType().lower().startswith('ixuss'):
        box = "ixuss"
        boxname = "Ixuss One/Zero"
    #Maram/OdinM9/M9
    elif getBoxType() == "odinm9":
        box = "odinm9"
        boxname = "Odin M9"
    elif getBoxType() == "odinm7":
        box = "odinm7"
        boxname = "Odin M7"
    elif getBoxType() == "odinm6":
        box = "odinm7"
        boxname = "Odin M6"
    elif getBoxType() == "maram9":
        box = "odinm9"
        boxname = "Odin M9"
    elif getBoxType() == "maram7":
        box = "odinm7"
        boxname = "Odin M7"
    elif getBoxType() == "maram6":
        box = "odinm7"
        boxname = "Odin M6"
    #Dreambox
    elif getBoxType() == "dm800se":
        box = "dreambox"
        boxname = "Dreambox"
    #XP1000
    elif getBoxType().startswith('xp1000'):
        box = "xp1000"
        boxname = "XP1000"
    elif getBoxType().startswith('venton'):
        box = "Venton"
    elif getBoxType() == "e3hd":
        box = "e3hd"
        boxname = "E3HD"
	#Xpeed LX-x
    elif getMachineBrand().startswith('GI'):
        box = "inihde"
        boxname = "GI Xpeed LX"
    elif getBoxType() == "axodin":
        box = "xp1000"
        boxname = "Opticum AX-Odin"
    elif getBoxType() == "starsatlx":
        box = "xp1000"
        boxname = "Starsat LX"
    elif getBoxType() == "classm":
        box = "xp1000"
        boxname = "Axas Class M"
    elif getBoxType().startswith('optimuss'):
        box = "optimuss"
        boxname = "Edision Optimuss"
    elif getBoxType().startswith('atemio'):
        box = "atemio"
        boxname = "Atemio"
    elif getBoxType() == "formuler1":
        box = "atemio"
        boxname = "Formuler F1"
    elif getBoxType() == "formuler3":
        box = "atemio"
        boxname = "Formuler F3"
except:
    pass

##read brand and machine for other OEMs
brandfile = "/etc/.brand"
if os.path.exists(brandfile) is True:
	brand = open(brandfile,"r")
	box = brand.readline().lower()
	brand.close()

machinefile = "/etc/.machine"
if os.path.exists(machinefile) is True:
	machine = open(machinefile,"r")
	boxmachine = machine.readline().lower()
	machine.close()

if os.path.exists("/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/downloader.py"):
    os.remove("/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/downloader.py")
else:
    pass

if os.path.exists("/usr/bin/ipkg"):
    pass
else:
   os.system("ln -s /usr/bin/opkg-cl /usr/bin/ipkg")
   os.system("ln -s /usr/bin/opkg-cl /usr/bin/ipkg-cl")

if os.path.exists("/usr/uninstall") == False:
    os.system("mkdir /usr/uninstall")

class Hdf_Downloader(Screen):
    skin = """
          <screen name="DownloadMenu" position="center,center" size="800,400" title="Select your Download">
                <widget name="downloadmenu" position="10,10" size="400,300" scrollbarMode="showOnDemand" />
                <ePixmap name="white" position="420,15" zPosition="10" size="2,300" pixmap="/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/whiter.png" transparent="0" alphatest="on" />
                <ePixmap name="1" position="760,225" zPosition="1" size="40,40" pixmap="skin_default/buttons/key_1.png" transparent="1" alphatest="on" />
                <widget name="key_1" position="550,227" zPosition="2" size="200,30" valign="right" halign="right" font="Regular;15" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <ePixmap name="2" position="760,250" zPosition="1" size="40,40" pixmap="skin_default/buttons/key_2.png" transparent="1" alphatest="on" />
                <widget name="key_2" position="550,252" zPosition="2" size="200,30" valign="right" halign="right" font="Regular;15" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <ePixmap name="3" position="760,275" zPosition="1" size="40,40" pixmap="skin_default/buttons/key_3.png" transparent="1" alphatest="on" />
                <widget name="key_3" position="550,277" zPosition="2" size="200,30" valign="right" halign="right" font="Regular;15" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <ePixmap name="4" position="760,300" zPosition="1" size="40,40" pixmap="skin_default/buttons/key_4.png" transparent="1" alphatest="on" />
                <widget name="key_4" position="550,302" zPosition="2" size="200,30" valign="right" halign="right" font="Regular;15" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <ePixmap name="5" position="760,325" zPosition="1" size="40,40" pixmap="skin_default/buttons/key_5.png" transparent="1" alphatest="on" />
                <widget name="key_5" position="550,327" zPosition="2" size="200,30" valign="right" halign="right" font="Regular;15" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <ePixmap name="6" position="760,350" zPosition="1" size="40,40" pixmap="skin_default/buttons/key_6.png" transparent="1" alphatest="on" />
                <widget name="key_6" position="550,352" zPosition="2" size="200,30" valign="right" halign="right" font="Regular;15" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <ePixmap name="7" position="760,375" zPosition="1" size="40,40" pixmap="skin_default/buttons/key_7.png" transparent="1" alphatest="on" />
                <widget name="key_7" position="550,377" zPosition="2" size="200,30" valign="right" halign="right" font="Regular;15" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <ePixmap name="0" position="760,400" zPosition="1" size="40,40" pixmap="skin_default/buttons/key_0.png" transparent="1" alphatest="on" />
                <widget name="key_0" position="550,402" zPosition="2" size="200,30" valign="right" halign="right" font="Regular;15" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <ePixmap name="red" position="30,320" zPosition="1" size="140,40" pixmap="skin_default/buttons/red.png" transparent="1" alphatest="on" />
                <ePixmap name="green" position="200,320" zPosition="1" size="140,40" pixmap="skin_default/buttons/green.png" transparent="1" alphatest="on" />
                <widget name="blue" position="370,320" zPosition="1" size="140,40" pixmap="skin_default/buttons/blue.png" transparent="1" alphatest="on" />
                <widget name="key_red" position="30,320" zPosition="2" size="140,40" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <widget name="key_green" position="200,320" zPosition="2" size="140,40" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <widget name="key_blue" position="370,320" zPosition="2" size="140,40" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <widget source="introduction" render="Label" position="0,370" size="560,30" zPosition="10" font="Regular;21" halign="center" valign="center" backgroundColor="#25062748" transparent="1" />
                <widget source="size" render="Label" position="500,15" size="100,30" zPosition="10" font="Regular;15" halign="left" valign="top" backgroundColor="#25062748" transparent="1" />
                <widget source="size2" render="Label" position="430,10" size="100,30" zPosition="10" font="Regular;21" halign="left" valign="top" backgroundColor="#25062748" transparent="1" />
                <widget source="description" render="Label" position="450,80" size="330,150" zPosition="10" font="Regular;15" halign="left" valign="top" backgroundColor="#25062748" transparent="1" />
                <widget source="description2" render="Label" position="430,50" size="150,30" zPosition="10" font="Regular;21" halign="left" valign="top" backgroundColor="#25062748" transparent="1" />
          </screen>"""
    def __init__(self, session , **kwargs):
        self.session = session
        self.skinAttributes = (())

##### Variables and lists
        self.box = box
        self.anyNewInstalled = False
        self.switch = "softcam"
        self.filesArray = []
        self.filesArrayClean = []
        self.filesArraySplit = []
        self.list = []
##### Download Source File
        try:
            import urllib2
            url = "http://addons.hdfreaks.cc/feeds/down.hdf"
            i = urllib2.urlopen(url)
            downfile = i.read()
            f = open("/tmp/.down.hdf", 'w')
            f.write(downfile)
            f.close()
        except:
            os.system("touch /tmp/.down.hdf")
##### Lets Start
        self.readSource()
        self.makeMenu()
        Screen.__init__(self, session)
        self["downloadmenu"] = MenuList(self.list)
        self["introduction"] = StaticText(_("Press OK to install the file."))
        self["size2"] = StaticText(_("Size:"))
        self["description2"] = StaticText(_("Description:"))
        self["actions"] = ActionMap(["WizardActions", "InputActions", "EPGSelectActions", "ColorActions"],
        {
            "ok" : self.ok,
            "1" : self.one,
            "2" : self.two,
            "3" : self.three,
            "4" : self.four,
            "5" : self.five,
            "6" : self.six,
            "7" : self.seven,
            "0" : self.zero,
            "back": self.cancel,
            "blue": self.preview,
            "info": self.info,
            "red": self.cancel,
            "green": self.ok,
            "up": self.up,
            "down": self.down,
            "left": self.left,
            "right": self.right,
            "menu": self.menu,
        }, -1)
        self["key_red"] = Label(_("Cancel"))
        self["key_green"] = Label(_("Download"))
        self["key_blue"] = Label(_(" "))
        self["key_1"] = Label(_("   Softcams/Cardreader"))
        self["key_2"] = Label(_("   Extra/Special-Updates"))
        self["key_3"] = Label(_("   Extra/Special-Plugins"))
        self["key_4"] = Label(_("   Bootlogos/Spinner"))
        self["key_5"] = Label(_("   Picons (not activ)"))
        self["key_6"] = Label(_("   ipk, tar.gz, tgz Installer"))
        self["key_7"] = Label(_("   IPTV Streams"))
        self["key_0"] = Label(_("   Uninstaller"))
        self["menu"] = Label(_("   Config Menu"))
        self["size"] = StaticText(_(" "))
        self["description"] = StaticText(_(" "))
        self["blue"] = Pixmap()
        self["blue"].hide()
        self.loadInfo()

##### Reading of files

    def readSource(self):
        sourceread = open("/tmp/.down.hdf", "r")
        for lines in sourceread.readlines():
            if lines.split('#')[0] == "":
                pass
            else:
                newLines = lines.split('#')
                self.filesArrayClean.append(newLines[1])
                self.filesArraySplit.append(lines.split('#'))
                self.filesArray.append(newLines[1].split('-'))

        sourceread.close()
        os.system("rm -rf /tmp/.down.hdf")

##### Building Menu

    def makeMenu(self):

        # TMP Install:
        # 3 Werte werden benoetigt 1. Dateiname
        i = 0
        if self.switch == "tmpinst":
            tmpInstFilesArray = os.listdir("/tmp/")
            while i < len(tmpInstFilesArray):
                if "ipk" in tmpInstFilesArray[i].split(".") or "tar" in tmpInstFilesArray[i].split(".") or "tgz" in tmpInstFilesArray[i].split("."):
                    self.list.append((_(tmpInstFilesArray[i]), "tmpinst"))
                i = i + 1
        # Uninstall:
        # 3 Werte werden benoetigt 1. Name 2. Dateiname 3. uninstall
        i = 0
        if self.switch == "uninstall":
            uninstFilesArray = sorted(os.listdir("/usr/uninstall"))
            while i < len(uninstFilesArray):
                if uninstFilesArray[i].split('_')[0] == "hdf":
                    self.list.append((_(uninstFilesArray[i].split('_')[1].split('.')[0]), uninstFilesArray[i], "uninstall"))
                i = i + 1
        # Download:
        # 4 Werte werden benoetigt 1. Name 2. Dateiname 3. Groesse 4. Description 5. download (wichtig bei def ok)
        i = 0
        while i < len(self.filesArray):
            if os.path.exists("/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/.devdown"):
                if self.switch in self.filesArray[i] or self.switch + "s" in self.filesArray[i] or self.switch + "shd" in self.filesArray[i]:
                    if self.switch == "extensions":
                        self.list.append((_(self.filesArray[i][3].split('.')[0]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))
                    if self.switch == "skin":
                        self.list.append((_(self.filesArray[i][3].split('.')[0]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))
                    if self.switch == "update":
                        self.list.append((_(self.filesArray[i][3].split('.')[0]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))
                    if self.switch == "softcam":
                        self.list.append((_(self.filesArray[i][3].split('.')[0]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))
                    if self.switch == "picon":
                        self.list.append((_(self.filesArray[i][2].split('.')[0]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))
            elif self.box in self.filesArraySplit[i][0]:
                if self.switch in self.filesArray[i] or self.switch + "s" in self.filesArray[i] or self.switch + "shd" in self.filesArray[i]:
                    if self.switch == "extensions":
                        if "2.7" in sys.version:
                            if "mips32el" in self.filesArrayClean[i] or "_all" in self.filesArrayClean[i]:
                                self.list.append((_(self.filesArray[i][3].split('.')[0]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))
                        else:
                            self.list.append((_(self.filesArray[i][3].split('.')[0]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))
                    if self.switch == "skin":
                        self.list.append((_(self.filesArray[i][3].split('.')[0]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))
                    if self.switch == "update":
                        self.list.append((_(self.filesArray[i][3].split('.')[0]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))
                    if self.switch == "softcam":
                        self.list.append((_(self.filesArray[i][3].split('.')[0]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))
                    if self.switch == "picon":
                        self.list.append((_(self.filesArray[i][2].split('.')[0]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))
            elif "all" in self.filesArraySplit[i][0]:
                if self.switch in self.filesArray[i][0].replace('_','.').split('.'):
                    if self.switch == "iptv":
                        self.list.append((_(self.filesArray[i][0].split('.')[1]), self.filesArrayClean[i] , "" + self.filesArraySplit[i][2] + "", "" + self.filesArraySplit[i][3] + "", "download"))

            i = i + 1
        self.list.append((_(" "), "none"))

    def delMenu(self):
        count = 0
        while len(self.list) > count:
            self.list.pop()

    def mkNewMenu(self):
        self.delMenu()
        self.makeMenu()
        self["downloadmenu"].moveToIndex(0)
        self.loadInfo()
        Screen.hide(self)
        Screen.show(self)

##### Onscreen Actions

    def loadInfo(self):
        self["blue"].hide()
        self["key_blue"].setText(" ")
        if "download" in self["downloadmenu"].l.getCurrentSelection():
            if self.switch == "skin" or self.switch == "picon":
                        self["blue"].show()
                        self["key_blue"].setText("Preview")
            self["key_green"].setText("Download")
            self["introduction"].setText("Press OK to install the file.")
            self["description"].setText(self["downloadmenu"].l.getCurrentSelection()[3])
            self["description2"].setText("Description: ")
            self["size"].setText(self["downloadmenu"].l.getCurrentSelection()[2])
            self["size2"].setText("Size: ")
            Screen.setTitle(self, "Select your Download for " + boxname )
        elif "uninstall" in self["downloadmenu"].l.getCurrentSelection():
            self["key_green"].setText("Remove")
            self["introduction"].setText("Press OK to remove the file.")
            self["description"].setText(" ")
            self["description2"].setText(" ")
            self["size"].setText(" ")
            self["size2"].setText(" ")
            Screen.setTitle(self, "Select your Removal")
        elif "tmpinst" in self["downloadmenu"].l.getCurrentSelection():
            self["key_green"].setText("Install")
            self["introduction"].setText("Press OK to install the file.")
            self["description"].setText(" ")
            self["description2"].setText(" ")
            self["size"].setText(" ")
            self["size2"].setText(" ")
            Screen.setTitle(self, "Select your local file to install")
        elif "cancel" or "none" in self["downloadmenu"].l.getCurrentSelection():
            self["key_green"].setText("Ok")
            self["introduction"].setText(" ")
            self["description"].setText("Press OK to do nothing")
            self["description2"].setText("Description: ")
            self["size"].setText("0")
            self["size2"].setText("Size: ")
            Screen.setTitle(self, "HDFreaks.cc Downloader")
        else:
            self["description"].setText(" ")
            self["size"].setText(" ")

        Screen.hide(self)
        Screen.show(self)

##### Executive Functions

    def restartGUI(self, answer):
        if answer is True:
            plugins.readPluginList(resolveFilename(SCOPE_PLUGINS))
            self.close()
        else:
            self.close()

    def uninstall(self, answer):
        if answer is True:
            os.chmod("/usr/uninstall/" + self["downloadmenu"].l.getCurrentSelection()[1], 755)
            os.system("sh /usr/uninstall/" + self["downloadmenu"].l.getCurrentSelection()[1] + "")
            self.anyNewInstalled = True
            Screen.hide(self)
            self.mkNewMenu()
            self.session.open(MessageBox, ("It's recommented to restart box for changes taking place!"), MessageBox.TYPE_INFO, timeout=10).setTitle(_("Uninstall complete"))
        else:
            self.close()

    def preview(self):
        if self.switch == "skin" or self.switch == "picon":
            file = self["downloadmenu"].l.getCurrentSelection()[1].split(".")[0] + ".jpg"
            url = "http://addons.hdfreaks.cc/feeds/" + file
            path = "/tmp/" + file
            import urllib
            if "<title>404 Not Found</title>" in open(path, "r").read():
                self.session.open(MessageBox, ("Sorry, no Preview available."), MessageBox.TYPE_ERROR).setTitle(_("No Preview"))
            else:
                self.session.open(PictureScreen, picPath=path)
        else:
            pass

    def recompile(self):
        if os.path.exists("/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/.devdown"):
            print "Starting Recompile"
            self.restartGUI(True)
        else:
            pass

###### Easter Egg

    def info(self):
        self.session.open(MessageBox, ("(c) HDF 2014\nSpecial thanks to koivo for testing\nGoogle for amounts of questions\nand\nTBX for telling me what Google couldn't"), MessageBox.TYPE_INFO, timeout=10).setTitle(_("HDFreaks.cc Downloader Info"))

###### Special Controls

    def ok(self):
        if "download" in self["downloadmenu"].l.getCurrentSelection():
            file = self["downloadmenu"].l.getCurrentSelection()[1]
            if not self.switch == "iptv":
                url = "http://addons.hdfreaks.cc/feeds/" + file
            else:
                url = "http://iptv.hdfreaks.cc/" + file
            path = "/tmp/" + file
            self.session.open(downloadfile, path, url)
            if not self.switch == "iptv":
                self.anyNewInstalled = True

        elif "tmpinst" in self["downloadmenu"].l.getCurrentSelection():
            file = self["downloadmenu"].l.getCurrentSelection()[0]
            filetype = file.split(".")[1]
            i = 1
            while i < len(file.split(".")):
                filetype = file.split(".")[i]
                if file.split(".")[i] != "ipk" or file.split(".")[i] != "tar" or file.split(".")[i] != "tgz":
                    i = i + 1
            if filetype == "ipk":
                com = "opkg install --force-overwrite /tmp/" + file + ""
            else:
                com = "tar xzvf /tmp/" + file + " -C /"
            self.session.open(Console,_("Install Log: %s") % (com), ["%s" %com])
        elif "uninstall" in self["downloadmenu"].l.getCurrentSelection():
            self.session.openWithCallback(self.uninstall, MessageBox, _("Do you want to uninstall the Plugin?"), MessageBox.TYPE_YESNO).setTitle(_("Uninstall?"))
        else:
            returnValue = "self." + self["downloadmenu"].l.getCurrentSelection()[1] + "()"
            eval(returnValue)

    def cancel(self):
        if self.anyNewInstalled is True:
            self.session.openWithCallback(self.restartGUI, MessageBox, _("Activate and reload the new installed Plugins now? \n\nNo Enigma GUI Restart needed!"), MessageBox.TYPE_YESNO).setTitle(_("Reload Plugins now?"))
        else:
            self.close()

    def none(self):
        pass

###### Category Controls

    def one(self):
        self.switch = "softcam"
        self.mkNewMenu()

    def two(self):
        self.switch = "update"
        self.mkNewMenu()

    def three(self):
        self.switch = "extensions"
        self.mkNewMenu()

    def four(self):
        self.switch = "skin"
        self.mkNewMenu()

    def five(self):
        self.switch = "picon"
        self.mkNewMenu()

    def six(self):
        self.switch = "tmpinst"
        self.mkNewMenu()

    def seven(self):
        self.switch = "iptv"
        self.mkNewMenu()

    def zero(self):
        self.switch = "uninstall"
        self.mkNewMenu()

    def menu(self):
		self.session.open(ConfigMenu)

##### Basic Controls

    def up(self):
        self["downloadmenu"].up()
        self.loadInfo()

    def down(self):
        self["downloadmenu"].down()
        self.loadInfo()

    def left(self):
        self["downloadmenu"].pageUp()
        self.loadInfo()

    def right(self):
        self["downloadmenu"].pageDown()
        self.loadInfo()

##### % Anzeige

class BufferThread():
    def __init__(self):
        self.progress = 0
        self.downloading = False
        self.error = ""
        self.download = None

    def startDownloading(self, filename, url):
        self.progress = 0
        self.downloading = True
        self.error = ""
        self.download = downloadWithProgress(url, filename)
        self.download.addProgress(self.httpProgress)
        self.download.start().addCallback(self.httpFinished).addErrback(self.httpFailed)

    def httpProgress(self, recvbytes, totalbytes):
        self.progress = int(100 * recvbytes / float(totalbytes))

    def httpFinished(self, string=""):
        self.downloading = False
        if string is not None:
            self.error = str(string)
        else:
            self.error = ""

    def httpFailed(self, failure_instance=None, error_message=""):
        self.downloading = False
        if error_message == "" and failure_instance is not None:
            error_message = failure_instance.getErrorMessage()
            self.error = str(error_message)

    def stop(self):
        self.progress = 0
        self.downloading = False
        self.error = ""
        self.download.stop()

bufferThread = BufferThread()

##### Downloader

class downloadfile(Screen):
    skin = """
        <screen name="downloadfile" position="center,center" size="300,300" title="Download File" >
                <widget name="info" position="0,5" size="290,200" font="Regular;18" transparent="1" backgroundColor="#415a80" halign="center" valign="center" />
                <widget name="progress" position="10,200" size="280,14" backgroundColor="#415a80" pixmap="skin_default/progress_big.png" borderWidth="2" borderColor="#cccccc" />
                <widget name="precent" position="125,225" size="50,20" font="Regular;19" halign="center" valign="center" backgroundColor="#415a80" zPosition="6" />
                <ePixmap name="red" position="10,260" zPosition="1" size="140,40" pixmap="skin_default/buttons/red.png" transparent="1" alphatest="on" />
                <ePixmap name="green" position="150,260" zPosition="1" size="140,40" pixmap="skin_default/buttons/green.png" transparent="1" alphatest="on" />
                <widget name="key_red" position="10,260" zPosition="2" size="140,40" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
                <widget name="key_green" position="150,260" zPosition="2" size="140,40" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
        </screen>"""

    def __init__(self, session, filename, url):
        self.session = session
        self.skin = downloadfile.skin
        Screen.__init__(self, session)
        self.url = url
        self.filename = filename
        self.infoTimer = eTimer()
        self.infoTimer.timeout.get().append(self.updateInfo)
        self.Shown = True
        self["info"] = Label(_("Downloading Plugin: %s") % self.filename)
        self["progress"] = ProgressBar()
        self["precent"] = Label()
        self["actions"] = ActionMap(["OkCancelActions", "ColorActions"],
                                    {
                                     "ok": self.okClicked,
                                     "cancel": self.exit,
                                     "green": self.okClicked,
                                     "red": self.exit
                                     }, -1)
        self["key_red"] = Label(_("Cancel"))
        self["key_green"] = Label(_("Show/Hide"))
        self.onLayoutFinish.append(self.downloadPlugin)

    def downloadPlugin(self):
        bufferThread.startDownloading(self.filename, self.url)
        self.infoTimer.start(300, False)

    def updateInfo(self):
        if bufferThread.error != "":
            self["info"].setText(bufferThread.error)
            self.infoTimer.stop()
        else:
            progress = int(bufferThread.progress)
            self["progress"].setValue(progress)
            self["precent"].setText(_("%s%%") % (progress))
            if progress == 100:
                self.infoTimer.stop()
                self.session.openWithCallback(self.install, MessageBox, _("Download complete. Install now?"), MessageBox.TYPE_YESNO).setTitle(_("Install?"))
                self.close(True)

    def okClicked(self):
        if self.Shown == True:
            self.hide()
            self.Shown = False
        else:
            self.show()
            self.Shown = True

    def exit(self):
        self.session.openWithCallback(self.StopDownLoad, MessageBox, _("Do you really want to stop the download?"), MessageBox.TYPE_YESNO).setTitle(_("Abort Download?"))

    def StopDownLoad(self, result):
        if result is True:
            bufferThread.download.stop()
            self.close(None)
        else:
            pass

    def install(self, answer):
        if answer is True:
            self.doInstall()

    def doInstall(self):
        if "tar.gz" in  self.filename:
            os.system("tar xzf " + self.filename + " -C /")
        elif "tgz" in  self.filename:
            os.system("tar xzf " + self.filename + " -C /")
        elif "ipk" in  self.filename:
            # Installiert das Plugin und liest den expliziten Pluginnamen (wichtig fuer remove)
            os.system("ipkg install " + self.filename + " | cut -d' ' -f2 | sort -u > /tmp/.ipkinst")
            # das ist der Pluginname
            pluginname = open("/tmp/.ipkinst", "r").readline()

            # Erklaerung:
            # Splittet vom Dateinamen Bsp: enigma2-plugin-extensions-cccaminfo_svn-2940-r0_all.ipk anhand von "-" und waehlt den 4 Teil aus
            # -> cccaminfo_svn-2940-r0_all.ipk
            # Jetzt wird noch am "_" gesplittet und der erste Teil ausgewaehlt -> cccaminfo
            if pluginname.split('-')[0] == "enigma2":
                f = open("/usr/uninstall/hdf_" + self.filename.split("-")[3].split('_')[0] + "_delfile_ipk.sh", 'w')
                print >> f, '#!/bin/sh \n\n', 'ipkg remove ' + pluginname, '\nrm -rf /usr/uninstall/hdf_' + self.filename.split("-")[3].split("_")[0] + '_delfile_ipk.sh'
                f.close()
                os.chmod("/usr/uninstall/hdf_" + self.filename.split("-")[3].split('_')[0] + "_delfile_ipk.sh", 755)
            else:
                pass
        elif "tv" in self.filename:
            os.system("cp " + self.filename + " /etc/enigma2/")
            filename = self.filename.split('/')[2]
            f = open("/etc/enigma2/bouquets.tv", "r")
            exists = False
            for line in f.readlines() :
                if filename in line.split("\""):
                    exists = True
            f.close()
            if not exists:
                os.system("echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET \"%s\" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv" % (filename))
         #   os.system("wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 &")
            eDVBDB.getInstance().reloadBouquets()
            eDVBDB.getInstance().reloadServicelist()
        os.remove(self.filename)

###########################################################################

class PictureScreen(Screen):

    skin="""
        <screen name="Preview" position="center,center" size="800,450" title="Preview" >
            <widget name="picture" position="0,0" size="800,450" zPosition="1" alphatest="on" />
        </screen>"""

    def __init__(self, session, picPath = None):
        Screen.__init__(self, session)
        self.picPath = picPath
        self.Scale = AVSwitch().getFramebufferScale()
        self.PicLoad = ePicLoad()
        self["picture"] = Pixmap()
        self["myActionMap"] = ActionMap(["SetupActions"],
        {
            "ok": self.cancel,
            "cancel": self.cancel
        }, -1)

        self.PicLoad.PictureData.get().append(self.DecodePicture)
        self.onLayoutFinish.append(self.ShowPicture)

    def ShowPicture(self):
        if self.picPath is not None:
            self.PicLoad.setPara([
                        self["picture"].instance.size().width(),
                        self["picture"].instance.size().height(),
                        self.Scale[0],
                        self.Scale[1],
                        0,
                        1,
                        "#002C2C39"])

            self.PicLoad.startDecode(self.picPath)

    def DecodePicture(self, PicInfo = ""):
        if self.picPath is not None:
            ptr = self.PicLoad.getData()
            self["picture"].instance.setPixmap(ptr)


    def cancel(self):
        self.close(None)

class ConfigMenu(ConfigListScreen, Screen):
	skin = """
		<screen name="config" position="center,center" size="300,300" title="Download File" >
				<widget name="config" position="10,10" size="290,210" scrollbarMode="showOnDemand" />
				<ePixmap name="red" position="10,260" zPosition="1" size="140,40" pixmap="skin_default/buttons/red.png" transparent="1" alphatest="on" />
				<ePixmap name="green" position="150,260" zPosition="1" size="140,40" pixmap="skin_default/buttons/green.png" transparent="1" alphatest="on" />
				<widget name="key_red" position="10,260" zPosition="2" size="140,40" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
				<widget name="key_green" position="150,260" zPosition="2" size="140,40" valign="center" halign="center" font="Regular;21" transparent="1" shadowColor="black" shadowOffset="-1,-1" />
				<widget source="help" render="Label" position="5,345" size="690,105" font="Regular;21" />
		</screen>"""
	def __init__(self, session):
		Screen.__init__(self, session)
		self.session = session
		self.skinAttributes = (())
		Screen.setTitle(self, _("Config Menu..."))
		self["status"] = StaticText()
		self["help"] = StaticText()
		self["key_red"] = Label(_("Cancel"))
		self["key_green"] = Label(_("Save"))

		self.onChangedEntry = [ ]
		self.list = []
		ConfigListScreen.__init__(self, self.list, session = self.session, on_change = self.changedEntry)
		self.createSetup()

		self["config"].onSelectionChanged.append(self.updateHelp)

		self["actions"] = ActionMap(["SetupActions", 'ColorActions'],
		{
			"ok": self.keySave,
			"cancel": self.keyCancel,
			"red": self.keyCancel,
			"green": self.keySave,
			"info": self.info
		}, -2)

		if not self.selectionChanged in self["config"].onSelectionChanged:
			self["config"].onSelectionChanged.append(self.selectionChanged)
		self.selectionChanged()
		self.changedEntry()

	def info(self):
		lastscan = config.downloader.autoupdate_last.value
		if lastscan:
			from Tools.FuzzyDate import FuzzyTime
			scanDate = ', '.join(FuzzyTime(lastscan))
		else:
			scanDate = _("never")

		try:
			nextTimer = str(iptvtimer.getNextTimerEntry()).split(",")[0].split("(")[1]
		except:
			nextTimer = "No Timer Configured"

		self.session.open(
			MessageBox,
			_("Last refresh was %s\nNext timer: %s") % (scanDate,nextTimer),
			type=MessageBox.TYPE_INFO
			)
		# just for debugging
		#iptvtimer.show()

	def keyLeft(self):
		ConfigListScreen.keyLeft(self)
		self.createSetup()

	def keyRight(self):
		ConfigListScreen.keyRight(self)
		self.createSetup()

	def createSetup(self):
		self.editListEntry = None
		self.list = []
		self.list.append(getConfigListEntry(_("IPTV AutoUpdate"), config.downloader.autoupdate, _("Start Update on enigma2 start?")))
		if config.downloader.autoupdate.getValue():
			self.list.append(getConfigListEntry(_("IPTV AutoUpdate Type"), config.downloader.autoupdate_type, _("Choose the type of AutoUpdate."), False))
			if config.downloader.autoupdate_type.value == "auto":
				self.list.append(getConfigListEntry(_("Start Update every Day at (hh:mm)"), config.downloader.autoupdate_time, _("An automated refresh will start at this time."), False))
			elif config.downloader.autoupdate_type.value == "periodic":
				self.list.append(getConfigListEntry(_("Start Update every "), config.downloader.autoupdate_timer, _("An automated refresh will start after this duration."), False))
			if config.downloader.autoupdate_type.value != "startup":
				self.list.append(getConfigListEntry(_("Run in Standby?"), config.downloader.autoupdate_runinstandby, _("Start Update when in Standby?")))

		self["config"].list = self.list
		self["config"].setList(self.list)
		if config.usage.sort_settings.value:
			self["config"].list.sort()

	def selectionChanged(self):
		self["status"].setText(self["config"].getCurrent()[2])

	def changedEntry(self):
		for x in self.onChangedEntry:
			x()
		self.selectionChanged()

	def getCurrentEntry(self):
		return self["config"].getCurrent()[0]

	def getCurrentValue(self):
		return str(self["config"].getCurrent()[1].getText())

	def updateHelp(self):
		cur = self["config"].getCurrent()
		if cur:
			self["help"].text = cur[2]

	def saveAll(self):
		for x in self["config"].list:
			x[1].save()
		configfile.save()

	def keySave(self):
		iptvtimer.clear()
		if config.downloader.autoupdate.getValue():
			iptvtimer.setRefreshTimer(self.createWaitTimer)
		else:
			self.stop()
		self.saveAll()
		self.close()

	def cancelConfirm(self, result):
		if not result:
			return
		for x in self["config"].list:
			x[1].cancel()
		self.close()

	def keyCancel(self):
		if self["config"].isChanged():
			self.session.openWithCallback(self.cancelConfirm, MessageBox, _("Really close without saving settings?"))
		else:
			self.close()

	def createWaitTimer(self):
		# Add wait timer to iptvtimer
		iptvtimer.add(IPTVTimerEntry(time() + 30, self.prepareRefresh))

	def prepareRefresh(self):
		self.isrunning = True
		return

	def stop(self):
		print "[IPTVTimer] Stopping Timer"
		iptvtimer.clear()

#### IPTV Updater Calls

try:
	import httplib
except:
	import http.client as httplib

def connected():
	c = httplib.HTTPConnection('hdfreaks.cc', 80)
	try:
		import socket
		socket.setdefaulttimeout(3)
		c.connect()
		c.request("HEAD", "/")
		c.close()
		return True
	except:
		print "[HDF-Toolbox]: Server offline"
		c.close()
		return False


def doIptvUpdate(**kwargs):
	import urllib2
	if connected():
		print "[HDF-Toolbox]: IPTV list update"
		os.chdir("/etc/enigma2")
		for filename in glob.glob("*iptv*.tv"):
			url = "http://iptv.hdfreaks.cc/" + filename
			iptvfile = "/etc/enigma2/" + str(filename)
			try:
				i = urllib2.urlopen(url)
				html = i.read()
				f = open(iptvfile, 'w')
				f.write(html)
				f.close()
				changed = True
                        except urllib2.HTTPError as e:
                                print type(e)    #catched
                                print "[HDF-Toolbox]: IPTV list update ... download error"
                        except socket.timeout as e:
                                print type(e)    #catched
                                print "[HDF-Toolbox]: IPTV list update ... download error"
                        except urllib2.URLError as e:
                                print type(e)    #catched
                                print "[HDF-Toolbox]: IPTV list update ... download error"
		return True
	else:
		return False


###### Standard Stuff

def main(session, **kwargs):
	try:
		session.open(Hdf_Downloader)
	except:
		self.session.open(MessageBox, ("There seems to be an Error!\nPlease check if your internet connection is established correctly."), MessageBox.TYPE_INFO, timeout=10).setTitle(_("HDFreaks.cc Downloader Error"))
