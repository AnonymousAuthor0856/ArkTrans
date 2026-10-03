import { router } from '@kit.ArkUI';

// --- Enums and Data Models ---

enum AppTheme { SYSTEM, DARK, LIGHT }
enum Fonts { POPPINS, INTER, MANROPE, MONTSERRAT, FIGTREE, OUTFIT, GOOGLE_SANS, SYSTEM_DEFAULT }
enum PaletteStyle { TONALSPOT, NEUTRAL, VIBRANT, EXPRESSIVE, RAINBOW, FRUITSALAD, MONOCHROME, FIDELITY, CONTENT }
enum Sections { Tasks, Habits }
enum ExportState { IDLE, EXPORTING, EXPORTED }
enum RestoreState { IDLE, RESTORING, RESTORED, FAILURE }

interface Theme {
  appTheme: AppTheme;
  isAmoled: boolean;
  isMaterialYou: boolean;
  font: Fonts;
  paletteStyle: PaletteStyle;
  seedColor: number; // Using number for color hex representation
}

interface BackupState {
  exportState: ExportState;
  restoreState: RestoreState;
}

interface VersionEntry {
  version: string;
  changes: string[];
}

interface SettingsState {
  changelog: VersionEntry[];
  currentVersion: string;
  backupState: BackupState;
  theme: Theme;
  is24Hr: boolean;
  reorderTasks: boolean;
  startOfTheWeekSunday: boolean;
  pauseNotifications: boolean;
  startingPage: Sections;
  isBiometricLockOn: boolean;
  isBiometricLockAvailable: boolean;
}

// --- Mock Data ---

const mockChangelog: VersionEntry[] = [
  {
    version: "1.3.0",
    changes: [
      "Added biometric lock support",
      "New palette styles: Rainbow, Fruit Salad",
      "Improved backup & restore performance",
      "Fixed notification scheduling bug",
    ],
  },
  {
    version: "1.2.0",
    changes: [
      "Introduced Material You theming",
      "Added font picker with 8 font choices",
      "Export/import settings backup",
      "Redesigned habit analytics page",
    ],
  },
  {
    version: "1.1.0",
    changes: [
      "Added habit calendar view",
      "Overall analytics page",
      "Bug fixes and performance improvements",
    ],
  },
  {
    version: "1.0.0",
    changes: ["Initial release", "Basic habit tracking", "Task management"],
  },
];

const mockSettingsState: SettingsState = {
  changelog: mockChangelog,
  currentVersion: "1.3.0",
  backupState: { exportState: ExportState.IDLE, restoreState: RestoreState.IDLE },
  theme: {
    appTheme: AppTheme.SYSTEM,
    isAmoled: false,
    isMaterialYou: true,
    font: Fonts.FIGTREE,
    paletteStyle: PaletteStyle.TONALSPOT,
    seedColor: 0xFF6750A4,
  },
  is24Hr: false,
  reorderTasks: false,
  startOfTheWeekSunday: false,
  pauseNotifications: false,
  startingPage: Sections.Tasks,
  isBiometricLockOn: false,
  isBiometricLockAvailable: true,
};

// --- Main Entry Component ---

@Entry
@Component
struct SettingsGraphPreview {
  @State currentScreen: string = 'Root';
  @State state: SettingsState = mockSettingsState;

  build() {
    Column() {
      if (this.currentScreen === 'Root') {
        SettingsListPage({
          state: this.state,
          onTogglePauseNotifications: (val: boolean) => { this.state.pauseNotifications = val; },
          onToggleReorderTasks: (val: boolean) => { this.state.reorderTasks = val; },
          onToggleShowHabits: (val: boolean) => {
            this.state.startingPage = val ? Sections.Habits : Sections.Tasks;
          },
          onToggleStartOfWeek: (val: boolean) => {
            this.state.startOfTheWeekSunday = val;
          },
          onToggleBiometric: (val: boolean) => {
            this.state.isBiometricLockOn = val;
          },
          onToggle24Hr: (val: boolean) => {
            this.state.is24Hr = val;
          },
          onNavigateToLookAndFeel: () => { this.currentScreen = 'LookAndFeel'; },
          onNavigateToBackup: () => { this.currentScreen = 'Backup'; },
          onNavigateToChangelog: () => { this.currentScreen = 'Changelog'; },
          onNavigateToAbout: () => { this.currentScreen = 'About'; },
        })
      } else if (this.currentScreen === 'LookAndFeel') {
        LookAndFeelPage({
          theme: this.state.theme,
          onChangeAppTheme: (theme: AppTheme) => { this.state.theme.appTheme = theme; },
          onChangeMaterialYou: (val: boolean) => { this.state.theme.isMaterialYou = val; },
          onChangeFont: (font: Fonts) => { this.state.theme.font = font; },
          onChangeAmoled: (val: boolean) => { this.state.theme.isAmoled = val; },
          onChangeSeedColor: (color: number) => { this.state.theme.seedColor = color; },
          onChangePaletteStyle: (style: PaletteStyle) => { this.state.theme.paletteStyle = style; },
          onBack: () => { this.currentScreen = 'Root'; },
        })
      } else if (this.currentScreen === 'Backup') {
        BackupPage({
          backupState: this.state.backupState,
          onExport: () => { this.state.backupState.exportState = ExportState.EXPORTING; },
          onRestore: () => { this.state.backupState.restoreState = RestoreState.RESTORING; },
          onBack: () => { this.currentScreen = 'Root'; },
        })
      } else if (this.currentScreen === 'Changelog') {
        ChangelogPage({
          changelog: this.state.changelog,
          onBack: () => { this.currentScreen = 'Root'; },
        })
      } else if (this.currentScreen === 'About') {
        AboutPage({
          versionName: this.state.currentVersion,
          onBack: () => { this.currentScreen = 'Root'; },
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FD') // Light purple background similar to screenshot
  }
}

// --- Helper Components ---

@Component
struct GroupedListItem {
  @Prop headline: string;
  @Prop supporting: string = "";
  @Prop leadingIcon: string = "";
  @Prop trailingIcon: string = "";
  @Prop shape: RoundedCornerShape = new RoundedCornerShape(0);
  @Prop onClick?: () => void;
  @BuilderParam trailing?: () => void;

  build() {
    Row() {
      if (this.leadingIcon !== "") {
        Text(this.leadingIcon)
          .fontSize(20)
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
          .backgroundColor('#E6E1E5') // SurfaceContainerHighest equivalent
          .borderRadius(20)
          .margin({ right: 16 })
      }

      Column() {
        Text(this.headline)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1C1B1F')
          .fontSize(16)
        
        if (this.supporting !== "") {
          Text(this.supporting)
            .fontColor('#49454F') // OnSurfaceVariant
            .fontSize(14)
            .margin({ top: 4 })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      if (this.trailing) {
        this.trailing()
      } else if (this.trailingIcon !== "") {
        Text(this.trailingIcon)
          .fontColor('#49454F')
          .fontSize(16)
      }
    }
    .width('100%')
    .padding(16)
    .borderRadius(this.shape)
    .onClick(() => {
      if (this.onClick) {
        this.onClick();
      }
    })
  }
}

@Component
struct SwitchSettingItem {
  @Prop headline: string;
  @Prop supporting: string;
  @Prop checked: boolean;
  @Prop onCheckedChange: (val: boolean) => void;
  @Prop shape: RoundedCornerShape;

  build() {
    Row() {
      Column() {
        Text(this.headline)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1C1B1F')
          .fontSize(16)
        
        Text(this.supporting)
          .fontColor('#49454F')
          .fontSize(14)
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .onChange((isOn: boolean) => {
          this.onCheckedChange(isOn);
        })
    }
    .width('100%')
    .padding(16)
    .borderRadius(this.shape)
  }
}

// --- Page Components ---

@Component
struct SettingsListPage {
  @ObjectLink state: SettingsState;
  @Prop onTogglePauseNotifications: (boolean) => void;
  @Prop onToggleReorderTasks: (boolean) => void;
  @Prop onToggleShowHabits: (boolean) => void;
  @Prop onToggleStartOfWeek: (boolean) => void;
  @Prop onToggleBiometric: (boolean) => void;
  @Prop onToggle24Hr: (boolean) => void;
  @Prop onNavigateToLookAndFeel: () => void;
  @Prop onNavigateToBackup: () => void;
  @Prop onNavigateToChangelog: () => void;
  @Prop onNavigateToAbout: () => void;
  @State showLanguagePicker: boolean = false;

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Settings")
          .fontWeight(FontWeight.Bold)
          .fontSize(28)
          .fontColor('#1C1B1F')
          .margin({ left: 16, bottom: 16 })
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Bottom)

      Scroll() {
        Column() {
          // Grit Plus Item
          GroupedListItem({
            headline: "Grit Plus",
            leadingIcon: "🛡",
            shape: new RoundedCornerShape(28),
            onClick: () => {},
            trailing: () => {
              Text("→").fontColor('#49454F').fontSize(16)
            }
          })
          .margin({ bottom: 16 })

          // Switches Group
          Column() {
            SwitchSettingItem({
              headline: "Pause Notifications",
              supporting: "Temporarily pause all habit reminders",
              checked: this.state.pauseNotifications,
              onCheckedChange: this.onTogglePauseNotifications,
              shape: new RoundedCornerShape([28, 28, 0, 0])
            })
            
            SwitchSettingItem({
              headline: "Reorder Tasks",
              supporting: "Drag to reorder tasks in the list",
              checked: this.state.reorderTasks,
              onCheckedChange: this.onToggleReorderTasks,
              shape: new RoundedCornerShape(0)
            })

            SwitchSettingItem({
              headline: "Show Habits",
              supporting: "Start the app on the Habits page",
              checked: this.state.startingPage === Sections.Habits,
              onCheckedChange: this.onToggleShowHabits,
              shape: new RoundedCornerShape(0)
            })

            SwitchSettingItem({
              headline: "Starting Day",
              supporting: "Start week on Sunday instead of Monday",
              checked: this.state.startOfTheWeekSunday,
              onCheckedChange: this.onToggleStartOfWeek,
              shape: new RoundedCornerShape(0)
            })

            if (this.state.isBiometricLockAvailable) {
              SwitchSettingItem({
                headline: "Biometric Lock",
                supporting: "Require fingerprint to open the app",
                checked: this.state.isBiometricLockOn,
                onCheckedChange: this.onToggleBiometric,
                shape: new RoundedCornerShape(0)
              })
            }

            SwitchSettingItem({
              headline: "Use 24-Hour Time",
              supporting: "Display time in 24-hour format",
              checked: this.state.is24Hr,
              onCheckedChange: this.onToggle24Hr,
              shape: new RoundedCornerShape([0, 0, 28, 28])
            })
          }
          .margin({ bottom: 16 })

          // Navigation Group 1
          Column() {
            GroupedListItem({
              headline: "Look & Feel",
              supporting: "Customize theme, font, and colors",
              leadingIcon: "🎨",
              trailingIcon: "→",
              shape: new RoundedCornerShape([28, 28, 0, 0]),
              onClick: this.onNavigateToLookAndFeel
            })
            GroupedListItem({
              headline: "Backup",
              supporting: "Export or restore your data",
              leadingIcon: "⬇",
              trailingIcon: "→",
              shape: new RoundedCornerShape([0, 0, 28, 28]),
              onClick: this.onNavigateToBackup
            })
          }
          .margin({ bottom: 16 })

          // Navigation Group 2
          Column() {
            GroupedListItem({
              headline: "About",
              supporting: `Grit ${this.state.currentVersion}`,
              leadingIcon: "ℹ",
              trailingIcon: "→",
              shape: new RoundedCornerShape([28, 28, 0, 0]),
              onClick: this.onNavigateToAbout
            })
            GroupedListItem({
              headline: "Changelog",
              leadingIcon: "✓",
              trailingIcon: "→",
              shape: new RoundedCornerShape([0, 0, 28, 28]),
              onClick: this.onNavigateToChangelog
            })
          }
          .margin({ bottom: 16 })

          // Language Item
          GroupedListItem({
            headline: "Language",
            supporting: "English",
            leadingIcon: "🌐",
            trailingIcon: "→",
            shape: new RoundedCornerShape(28),
            onClick: () => { this.showLanguagePicker = true; }
          })
        }
        .padding({ left: 12, right: 12, bottom: 60 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FD')
  }
}

@Component
struct LookAndFeelPage {
  @ObjectLink theme: Theme;
  @Prop onChangeAppTheme: (AppTheme) => void;
  @Prop onChangeMaterialYou: (boolean) => void;
  @Prop onChangeFont: (Fonts) => void;
  @Prop onChangeAmoled: (boolean) => void;
  @Prop onChangeSeedColor: (number) => void;
  @Prop onChangePaletteStyle: (PaletteStyle) => void;
  @Prop onBack: () => void;
  @State showColorPicker: boolean = false;

  build() {
    Column() {
      // Top Bar
      Row() {
        Button("←")
          .type(ButtonType.Circle)
          .backgroundColor('#E6E1E5')
          .fontColor('#1C1B1F')
          .onClick(this.onBack)
          .margin({ left: 16 })
        
        Text("Look & Feel")
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
          .fontColor('#1C1B1F')
          .margin({ left: 16 })
      }
      .width('100%')
      .height(60)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // App Theme Section
          Column() {
            Row() {
              Text(this.getAppThemeIcon())
                .fontSize(20)
                .width(40)
                .height(40)
                .textAlign(TextAlign.Center)
                .backgroundColor('#E6E1E5')
                .borderRadius(20)
                .margin({ right: 16 })
              
              Text("App Theme")
                .fontWeight(FontWeight.Medium)
                .fontColor('#1C1B1F')
                .fontSize(16)
            }
            .width('100%')
            .padding(16)
            .borderRadius(new RoundedCornerShape([28, 28, 0, 0]))

            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              ForEach(Object.values(AppTheme), (item: AppTheme) => {
                Button(this.getAppThemeLabel(item))
                  .type(ButtonType.Normal)
                  .backgroundColor(this.theme.appTheme === item ? '#D0BCFF' : '#E6E1E5')
                  .fontColor(this.theme.appTheme === item ? '#1C1B1F' : '#49454F')
                  .borderRadius(16)
                  .margin(4)
                  .onClick(() => this.onChangeAppTheme(item))
              })
            }
            .width('100%')
            .padding({ left: 52, right: 16, bottom: 8 })
          }

          // Material You Switch
          SwitchSettingItem({
            headline: "Material You",
            supporting: "Use dynamic colors from your wallpaper",
            checked: this.theme.isMaterialYou,
            onCheckedChange: this.onChangeMaterialYou,
            shape: new RoundedCornerShape(0)
          })

          // Font Section
          Column() {
            Row() {
              Text("F")
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .width(40)
                .height(40)
                .textAlign(TextAlign.Center)
                .backgroundColor('#E6E1E5')
                .borderRadius(20)
                .margin({ right: 16 })
              
              Text("Font")
                .fontWeight(FontWeight.Medium)
                .fontColor('#1C1B1F')
                .fontSize(16)
            }
            .width('100%')
            .padding(16)
            
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              ForEach(Object.values(Fonts), (item: Fonts) => {
                Button(this.capitalizeFirstLetter(item.toString()))
                  .type(ButtonType.Normal)
                  .backgroundColor(this.theme.font === item ? '#D0BCFF' : '#E6E1E5')
                  .fontColor(this.theme.font === item ? '#1C1B1F' : '#49454F')
                  .borderRadius(16)
                  .margin(4)
                  .onClick(() => this.onChangeFont(item))
              })
            }
            .width('100%')
            .padding({ left: 52, right: 16, bottom: 8 })
          }
          .borderRadius(this.theme.isMaterialYou ? new RoundedCornerShape([0, 0, 28, 28]) : new RoundedCornerShape(0))

          if (!this.theme.isMaterialYou) {
            // AMOLED Switch
            SwitchSettingItem({
              headline: "Use AMOLED Black",
              supporting: "Enable pure black for AMOLED screens",
              checked: this.theme.isAmoled,
              onCheckedChange: this.onChangeAmoled,
              shape: new RoundedCornerShape(0)
            })

            // Seed Color
            Row() {
              Column() {
                Text("Select Seed Color")
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1C1B1F')
                  .fontSize(16)
                Text("Choose a base color for the theme")
                  .fontColor('#49454F')
                  .fontSize(14)
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Button()
                .type(ButtonType.Circle)
                .backgroundColor(`#${this.theme.seedColor.toString(16).padStart(6, '0')}`)
                .width(32)
                .height(32)
                .onClick(() => { this.showColorPicker = true; })
            }
            .width('100%')
            .padding(16)
            .borderRadius(new RoundedCornerShape(0))

            // Palette Style
            Column() {
              Row() {
                Text("🎨")
                  .fontSize(20)
                  .width(40)
                  .height(40)
                  .textAlign(TextAlign.Center)
                  .backgroundColor('#E6E1E5')
                  .borderRadius(20)
                  .margin({ right: 16 })
                
                Text("Palette Style")
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1C1B1F')
                  .fontSize(16)
              }
              .width('100%')
              .padding(16)
              
              Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
                ForEach(Object.values(PaletteStyle), (item: PaletteStyle) => {
                  Button(this.capitalizeFirstLetter(item.toString()))
                    .type(ButtonType.Normal)
                    .backgroundColor(this.theme.paletteStyle === item ? '#D0BCFF' : '#E6E1E5')
                    .fontColor(this.theme.paletteStyle === item ? '#1C1B1F' : '#49454F')
                    .borderRadius(16)
                    .margin(4)
                    .fontSize(12)
                    .onClick(() => this.onChangePaletteStyle(item))
                })
              }
              .width('100%')
              .padding({ left: 52, right: 16, bottom: 8 })
            }
            .borderRadius(new RoundedCornerShape([0, 0, 28, 28]))
          }
        }
        .padding({ left: 12, right: 12, bottom: 60 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FD')
  }

  getAppThemeIcon(): string {
    switch (this.theme.appTheme) {
      case AppTheme.SYSTEM: return "⚙";
      case AppTheme.DARK: return "🌙";
      case AppTheme.LIGHT: return "☀";
      default: return "⚙";
    }
  }

  getAppThemeLabel(theme: AppTheme): string {
    switch (theme) {
      case AppTheme.SYSTEM: return "System";
      case AppTheme.DARK: return "Dark";
      case AppTheme.LIGHT: return "Light";
      default: return "System";
    }
  }

  capitalizeFirstLetter(str: string): string {
    return str.charAt(0).toUpperCase() + str.slice(1);
  }
}

@Component
struct BackupPage {
  @ObjectLink backupState: BackupState;
  @Prop onExport: () => void;
  @Prop onRestore: () => void;
  @Prop onBack: () => void;

  build() {
    Column() {
      // Top Bar
      Row() {
        Button("←")
          .type(ButtonType.Circle)
          .backgroundColor('#E6E1E5')
          .fontColor('#1C1B1F')
          .onClick(this.onBack)
          .margin({ left: 16 })
        
        Text("Backup")
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
          .fontColor('#1C1B1F')
          .margin({ left: 16 })
      }
      .width('100%')
      .height(60)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // Export Section
          Column() {
            Row() {
              Text("📤")
                .fontSize(20)
                .width(40)
                .height(40)
                .textAlign(TextAlign.Center)
                .backgroundColor('#E6E1E5')
                .borderRadius(20)
                .margin({ right: 16 })
              
              Column() {
                Text("Export")
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1C1B1F')
                  .fontSize(16)
                Text("Save all your data as a JSON file")
                  .fontColor('#49454F')
                  .fontSize(14)
                  .margin({ top: 4 })
              }
            }
            .width('100%')
            .padding(16)
            .borderRadius(new RoundedCornerShape([28, 28, 0, 0]))

            Button(this.getExportButtonText())
              .type(ButtonType.Capsule)
              .backgroundColor('#6750A4')
              .fontColor('#FFFFFF')
              .enabled(this.backupState.exportState === ExportState.IDLE)
              .onClick(this.onExport)
              .margin({ left: 52, right: 16, bottom: 8 })
          }

          // Restore Section
          Column() {
            Row() {
              Text("⬇")
                .fontSize(20)
                .width(40)
                .height(40)
                .textAlign(TextAlign.Center)
                .backgroundColor('#E6E1E5')
                .borderRadius(20)
                .margin({ right: 16 })
              
              Column() {
                Text("Restore")
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1C1B1F')
                  .fontSize(16)
                Text("Restore data from a backup file")
                  .fontColor('#49454F')
                  .fontSize(14)
                  .margin({ top: 4 })
              }
            }
            .width('100%')
            .padding(16)
            
            Button(this.getRestoreButtonText())
              .type(ButtonType.Capsule)
              .backgroundColor('#6750A4')
              .fontColor('#FFFFFF')
              .enabled(this.backupState.restoreState === RestoreState.IDLE || 
                       this.backupState.restoreState === RestoreState.FAILURE)
              .onClick(this.onRestore)
              .margin({ left: 52, right: 16, bottom: 8 })
          }
          .borderRadius(new RoundedCornerShape([0, 0, 28, 28]))
        }
        .padding({ left: 12, right: 12, bottom: 60 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FD')
  }

  getExportButtonText(): string {
    switch (this.backupState.exportState) {
      case ExportState.IDLE: return "▶ Export";
      case ExportState.EXPORTING: return "Exporting…";
      case ExportState.EXPORTED: return "✓ Done";
      default: return "▶ Export";
    }
  }

  getRestoreButtonText(): string {
    switch (this.backupState.restoreState) {
      case RestoreState.IDLE: return "▶ Restore";
      case RestoreState.RESTORING: return "Restoring…";
      case RestoreState.RESTORED: return "✓ Done";
      case RestoreState.FAILURE: return "⚠ Failed — tap to retry";
      default: return "▶ Restore";
    }
  }
}

@Component
struct ChangelogPage {
  @Prop changelog: VersionEntry[];
  @Prop onBack: () => void;

  build() {
    Column() {
      // Top Bar
      Row() {
        Button("←")
          .type(ButtonType.Circle)
          .backgroundColor('#E6E1E5')
          .fontColor('#1C1B1F')
          .onClick(this.onBack)
          .margin({ left: 16 })
        
        Text("Changelog")
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
          .fontColor('#1C1B1F')
          .margin({ left: 16 })
      }
      .width('100%')
      .height(60)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          ForEach(this.changelog, (entry: VersionEntry) => {
            Column() {
              Text(entry.version)
                .fontWeight(FontWeight.Bold)
                .fontSize(20)
                .fontColor('#1C1B1F')
                .margin({ top: 16, bottom: 8 })
              
              ForEach(entry.changes, (change: string, index: number) => {
                ListItemComponent({ text: change, index: index, total: entry.changes.length })
              })
            }
          })
        }
        .padding({ left: 16, right: 16, bottom: 60 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FD')
  }
}

@Component
struct ListItemComponent {
  @Prop text: string;
  @Prop index: number;
  @Prop total: number;

  build() {
    Text(this.text)
      .fontColor('#1C1B1F')
      .fontSize(16)
      .padding(16)
      .borderRadius(this.getShape())
  }

  getShape(): RoundedCornerShape {
    if (this.total === 1) {
      return new RoundedCornerShape(28);
    } else if (this.index === 0) {
      return new RoundedCornerShape([28, 28, 0, 0]);
    } else if (this.index === this.total - 1) {
      return new RoundedCornerShape([0, 0, 28, 28]);
    } else {
      return new RoundedCornerShape(0);
    }
  }
}

@Component
struct AboutPage {
  @Prop versionName: string;
  @Prop onBack: () => void;
  @State showLicense: boolean = false;

  build() {
    Column() {
      // Top Bar
      Row() {
        Button("←")
          .type(ButtonType.Circle)
          .backgroundColor('#E6E1E5')
          .fontColor('#1C1B1F')
          .onClick(this.onBack)
          .margin({ left: 16 })
        
        Text("About")
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
          .fontColor('#1C1B1F')
          .margin({ left: 16 })
      }
      .width('100%')
      .height(60)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // App Info Card
          Column() {
            Row() {
              Text("🛡")
                .fontSize(32)
                .width(64)
                .height(64)
                .textAlign(TextAlign.Center)
                .backgroundColor('#E8DEF8') // PrimaryContainer
                .borderRadius(16)
                .margin({ right: 16 })
              
              Column() {
                Text("Grit")
                  .fontWeight(FontWeight.Bold)
                  .fontSize(24)
                  .fontColor('#1C1B1F')
                Text(this.versionName)
                  .fontColor('#6750A4') // Primary
                  .fontSize(16)
                  .margin({ top: 4 })
              }
              .layoutWeight(1)

              Button("💬")
                .type(ButtonType.Circle)
                .backgroundColor('#E6E1E5')
                .fontColor('#1C1B1F')
                .margin({ right: 8 })
              
              Button("🐙")
                .type(ButtonType.Circle)
                .backgroundColor('#E6E1E5')
                .fontColor('#1C1B1F')
            }
            .width('100%')
            .padding(16)
            .borderRadius(new RoundedCornerShape([28, 28, 0, 0]))
          }

          // Developer Info Card
          Column() {
            Row() {
              Text("👨‍💻")
                .fontSize(32)
                .width(64)
                .height(64)
                .textAlign(TextAlign.Center)
                .backgroundColor('#E0D6EB') // TertiaryContainer
                .borderRadius(12)
                .margin({ right: 16 })
              
              Column() {
                Text("Shubham Gorai")
                  .fontWeight(FontWeight.Bold)
                  .fontSize(20)
                  .fontColor('#1C1B1F')
                Text("Developer")
                  .fontColor('#7952A3') // Tertiary
                  .fontSize(14)
                  .margin({ top: 4 })
              }
            }
            .width('100%')
            .padding(16)
            
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              ForEach([
                { emoji: "🐙", label: "GitHub" },
                { emoji: "🌍", label: "Website" },
                { emoji: "✉", label: "Email" }
              ], (item: {emoji: string, label: string}) => {
                Button()
                  .type(ButtonType.Circle)
                  .backgroundColor('#E6E1E5')
                  .width(44)
                  .height(44)
                  .margin(4)
                  .child(Column() {
                    Text(item.emoji).fontSize(12)
                    Text(item.label).fontSize(10).margin({ top: 2 })
                  })
              })
            }
            .padding({ left: 80, top: 8 })
          }
          .borderRadius(new RoundedCornerShape([0, 0, 28, 28]))
          .margin({ top: 2 })

          // Support Links
          Column() {
            GroupedListItem({
              headline: "Buy Me a Coffee",
              supporting: "Support the developer",
              leadingIcon: "☕",
              trailingIcon: "↗",
              shape: new RoundedCornerShape([28, 28, 0, 0])
            })
            GroupedListItem({
              headline: "Help Translate",
              supporting: "Contribute translations on Weblate",
              leadingIcon: "🌐",
              trailingIcon: "↗",
              shape: new RoundedCornerShape([0, 0, 28, 28])
            })
          }
          .margin({ top: 16 })

          // License
          GroupedListItem({
            headline: "License",
            supporting: "GPL-3.0 License",
            leadingIcon: "📜",
            shape: new RoundedCornerShape(28),
            onClick: () => { this.showLicense = true; }
          })
          .margin({ top: 16 })
        }
        .padding({ left: 16, right: 16, bottom: 60 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FD')
  }
}