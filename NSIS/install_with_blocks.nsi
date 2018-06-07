!include "MUI2.nsh"

Name "BitCrystal2"

Outfile "BitCrystal2_setup.exe"

!define PRODUCT_NAME "BitCrystal 2"
!define EXE_NAME "bitcrystal-qt.exe"
!define CONFIGDATADIR "$APPDATA\BitCrystal_V20"

!define MUI_ICON "..\src\qt\res\icons\Bitcoin.ico"
!define MUI_UNICON "..\src\qt\res\icons\Bitcoin.ico"

# Pages
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

CRCCheck On

# define the directory to install to, the desktop in this case as specified  
# by the predefined $DESKTOP variable
InstallDir $PROGRAMFILES32\BitCrystal2

# default section
Section
 
	# define the output path for this file
	SetOutPath $INSTDIR

	# create the uninstaller
	WriteUninstaller "$INSTDIR\uninstall.exe"
	CreateShortCut "$SMPROGRAMS\Uninstall BitCrystal2.lnk" "$INSTDIR\uninstall.exe"
	 
	# define what to install and place it in the output path
	File ..\release\bitcrystal-qt.exe
	File libgcc_s_dw2-1.dll
	File libstdc++-6.dll
	File libwinpthread-1.dll
	File QtCore4.dll
	File QtGui4.dll
	File QtNetwork4.dll

	# Delete old config files
	Delete "${CONFIGDATADIR}\peers.dat"
	Delete "${CONFIGDATADIR}\bitcrystal.conf"
	RMDir /r "${CONFIGDATADIR}\blocks"
	RMDir /r "${CONFIGDATADIR}\chainstate"
	RMDir /r "${CONFIGDATADIR}\database"

	# Copy the blockchain blocks (this helps to speed up wallet sync up with network)
	SetOutPath ${CONFIGDATADIR}
	File /r "blockchainfix\*"
	File "bitcrystal.conf"

	# create desktop shortcut
	CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${EXE_NAME}" ""
 
SectionEnd

# uninstaller section start
Section "uninstall"

	RMDir /r $INSTDIR
	RMDir $INSTDIR
 
    # remove the shortcut from the start menu
    Delete "$SMPROGRAMS\Uninstall BitCrystal2.lnk"
	
	# remove the desktop shortcut
    Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
 
SectionEnd