@Entry
@Component
struct Index {
  @State showLanguagePicker: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === LazyColumn ===
      List({ space: 16 }) {
        // === GroupedListItem (Grit Plus) ===
        ListItem() {
          Row() {
            Text('🛡').fontSize(20).margin({ right: 16 })
            Column() {
              Text('Grit Plus').fontWeight(FontWeight.Medium).fontSize(18)
            }
            Blank()
          }.width('100%').padding(16).backgroundColor('#F5F5F5')
        }

        // === Section (Switches) ===
        ListItemGroup() {
          // SwitchSettingItem: Pause Notifications
          ListItem() {
            Row() {
              Column() {
                Text('Pause Notifications').fontWeight(FontWeight.Medium).fontSize(16)
                Text('Temporarily pause all habit reminders').fontSize(14).fontColor('#424940')
              }
              Blank()
              Toggle({ type: ToggleType.Switch, isOn: true })
            }.width('100%').padding(16).backgroundColor('#FFF')
          }
          // SwitchSettingItem: Reorder Tasks
          ListItem() {
            Row() {
              Column() {
                Text('Reorder Tasks').fontWeight(FontWeight.Medium).fontSize(16)
                Text('Drag to reorder tasks in the list').fontSize(14).fontColor('#424940')
              }
              Blank()
              Toggle({ type: ToggleType.Switch, isOn: false })
            }.width('100%').padding(16).backgroundColor('#FFF')
          }
          // SwitchSettingItem: Show Habits
          ListItem() {
            Row() {
              Column() {
                Text('Show Habits').fontWeight(FontWeight.Medium).fontSize(16)
                Text('Start the app on the Habits page').fontSize(14).fontColor('#424940')
              }
              Blank()
              Toggle({ type: ToggleType.Switch, isOn: true })
            }.width('100%').padding(16).backgroundColor('#FFF')
          }
          // SwitchSettingItem: Starting Day
          ListItem() {
            Row() {
              Column() {
                Text('Starting Day').fontWeight(FontWeight.Medium).fontSize(16)
                Text('Start week on Sunday instead of Monday').fontSize(14).fontColor('#424940')
              }
              Blank()
              Toggle({ type: ToggleType.Switch, isOn: false })
            }.width('100%').padding(16).backgroundColor('#FFF')
          }
          // SwitchSettingItem: Biometric Lock
          ListItem() {
            Row() {
              Column() {
                Text('Biometric Lock').fontWeight(FontWeight.Medium).fontSize(16)
                Text('Require fingerprint to open the app').fontSize(14).fontColor('#424940')
              }
              Blank()
              Toggle({ type: ToggleType.Switch, isOn: true })
            }.width('100%').padding(16).backgroundColor('#FFF')
          }
          // SwitchSettingItem: Use 24-Hour Time
          ListItem() {
            Row() {
              Column() {
                Text('Use 24-Hour Time').fontWeight(FontWeight.Medium).fontSize(16)
                Text('Display time in 24-hour format').fontSize(14).fontColor('#424940')
              }
              Blank()
              Toggle({ type: ToggleType.Switch, isOn: false })
            }.width('100%').padding(16).backgroundColor('#FFF')
          }
        }

        // === Section (Look & Feel, Backup) ===
        ListItemGroup() {
          // GroupedListItem: Look & Feel
          ListItem() {
            Row() {
              Text('🎨').fontSize(20).margin({ right: 16 })
              Column() {
                Text('Look & Feel').fontWeight(FontWeight.Medium).fontSize(16)
                Text('Customize theme, font, and colors').fontSize(14).fontColor('#424940')
              }
              Blank()
              Text('→').fontSize(16).fontColor('#424940')
            }.width('100%').padding(16).backgroundColor('#FFF')
          }
          // GroupedListItem: Backup
          ListItem() {
            Row() {
              Text('⬇').fontSize(20).margin({ right: 16 })
              Column() {
                Text('Backup').fontWeight(FontWeight.Medium).fontSize(16)
                Text('Export or restore your data').fontSize(14).fontColor('#424940')
              }
              Blank()
              Text('→').fontSize(16).fontColor('#424940')
            }.width('100%').padding(16).backgroundColor('#FFF')
          }
        }

        // === Section (About, Changelog) ===
        ListItemGroup() {
          // GroupedListItem: About
          ListItem() {
            Row() {
              Text('ℹ').fontSize(20).margin({ right: 16 })
              Column() {
                Text('About').fontWeight(FontWeight.Medium).fontSize(16)
                Text('Grit 1.3.0').fontSize(14).fontColor('#424940')
              }
              Blank()
              Text('→').fontSize(16).fontColor('#424940')
            }.width('100%').padding(16).backgroundColor('#FFF')
          }
          // GroupedListItem: Changelog
          ListItem() {
            Row() {
              Text('✓').fontSize(20).margin({ right: 16 })
              Column() {
                Text('Changelog').fontWeight(FontWeight.Medium).fontSize(16)
              }
              Blank()
              Text('→').fontSize(16).fontColor('#424940')
            }.width('100%').padding(16).backgroundColor('#FFF')
          }
        }

        // === GroupedListItem (Language) ===
        ListItem() {
          Row() {
            Text('🌐').fontSize(20).margin({ right: 16 })
            Column() {
              Text('Language').fontWeight(FontWeight.Medium).fontSize(16)
              Text('English').fontSize(14).fontColor('#424940')
            }
            Blank()
            Text('→').fontSize(16).fontColor('#424940')
          }.width('100%').padding(16).backgroundColor('#F5F5F5')
        }
      }.width('100%').height('100%').padding({ left: 12, right: 12, top: 16, bottom: 60 })

      // === LargeTopAppBar ===
      Column() {
        Text('Settings').fontWeight(FontWeight.Bold).fontSize(24).margin({ top: 40, left: 16 })
      }.width('100%').height(100).backgroundColor('#FFF')
    }.width('100%').height('100%')
  }
}