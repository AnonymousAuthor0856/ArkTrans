@Entry
@Component
struct Index {
  @State pauseNotifications: boolean = false
  @State reorderTasks: boolean = false
  @State showHabits: boolean = false
  @State startOfTheWeekSunday: boolean = false
  @State isBiometricLockOn: boolean = false
  @State is24Hr: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      List({ space: 16 }) {
        // Grit Plus Item
        ListItem() {
          Row() {
            Row() {
              Text('🛡')
                .fontSize(20)
                .textAlign(TextAlign.Center)
            }
            .width(40)
            .height(40)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .backgroundColor('#E8E3EB')
            .borderRadius(20)

            Column() {
              Text('Grit Plus')
                .fontWeight(FontWeight.Medium)
                .fontColor('#1C1B1F')
                .fontSize(16)
            }
            .margin({ left: 16 })
            .alignItems(HorizontalAlign.Start)
            .width('100%')

            Text('→')
              .fontColor('#79747E')
              .fontSize(20)
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .backgroundColor('#F3EDF7')
          .borderRadius(16)
        }

        // Switch Settings Group
        ListItem() {
          Column({ space: 2 }) {
            this.SwitchItem('Pause Notifications', 'Temporarily pause all habit reminders', this.pauseNotifications, (val) => { this.pauseNotifications = val }, true)
            this.SwitchItem('Reorder Tasks', 'Drag to reorder tasks in the list', this.reorderTasks, (val) => { this.reorderTasks = val }, false)
            this.SwitchItem('Show Habits', 'Start the app on the Habits page', this.showHabits, (val) => { this.showHabits = val }, false)
            this.SwitchItem('Starting Day', 'Start week on Sunday instead of Monday', this.startOfTheWeekSunday, (val) => { this.startOfTheWeekSunday = val }, false)
            this.SwitchItem('Biometric Lock', 'Require fingerprint to open the app', this.isBiometricLockOn, (val) => { this.isBiometricLockOn = val }, false)
            this.SwitchItem('Use 24-Hour Time', 'Display time in 24-hour format', this.is24Hr, (val) => { this.is24Hr = val }, true)
          }
          .clip(true)
          .backgroundColor('#F3EDF7')
          .borderRadius(16)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 12, right: 12, top: 16, bottom: 60 })
      .backgroundColor('#FCF2FF')

      // Top App Bar
      Column() {
        Text('Settings')
          .fontWeight(FontWeight.Bold)
          .fontSize(32)
          .fontColor('#1C1B1F')
          .margin({ top: 50, left: 20, bottom: 20 })
      }
      .width('100%')
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FCF2FF')
  }

  @Builder
  SwitchItem(headline: string, supporting: string, checked: boolean, onChange: (val: boolean) => void, isLast: boolean) {
    Row() {
      Column() {
        Text(headline)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1C1B1F')
          .fontSize(16)
        
        Text(supporting)
          .fontColor('#49454F')
          .fontSize(14)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: checked })
        .onChange((isOn: boolean) => {
          onChange(isOn)
        })
        .width(52)
        .height(32)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
  }
}