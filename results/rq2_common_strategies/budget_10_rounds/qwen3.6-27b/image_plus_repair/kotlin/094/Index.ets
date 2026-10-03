@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true; // true = Locked/Secure, false = Unlocked

  build() {
    Column() {
      Scroll() {
        Column({ space: 24 }) {
          // Header Section
          this.HeaderSection()

          // Master Status Card
          this.MasterStatusCard()

          // Access Points List
          this.AccessPointsList()

          // Recent Activity (Optional based on screenshot cut-off, but included for completeness)
          this.ActivityLog()
        }
        .padding({ left: 24, right: 24, top: 50, bottom: 100 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontColor('#9E9E9E')
          .fontSize(16)
          .fontWeight(FontWeight.Normal)

        Text('David Miller')
          .fontColor('#212121')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 4 })
      }

      Blank().layoutWeight(1)

      // Profile Icon Circle
      Row() {
        Image($r('app.media.ic_person')) // Placeholder for Person Icon
          .width(24)
          .height(24)
          .fillColor('#212121')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MasterStatusCard() {
    Column() {
      // Central Lock Icon Container
      Row() {
        Image($r('app.media.ic_lock')) // Placeholder for Lock Icon
          .width(36)
          .height(36)
          .fillColor(this.masterLockState ? '#212121' : '#4CAF50')
      }
      .width(80)
      .height(80)
      .borderRadius(40)
      .backgroundColor(Color.White)
      .border({ width: 2, color: this.masterLockState ? 'rgba(33,33,33,0.1)' : 'rgba(76,175,80,0.1)', style: BorderStyle.Solid })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
        this.masterLockState = !this.masterLockState
      })

      Text(this.masterLockState ? 'SECURE' : 'UNLOCKED')
        .fontColor(this.masterLockState ? '#212121' : '#4CAF50')
        .fontSize(28)
        .fontWeight(FontWeight.Black)
        .letterSpacing(2)
        .margin({ top: 16 })

      Text(this.masterLockState ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontColor('#9E9E9E')
        .fontSize(16)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(24)
    .borderRadius(24)
    .backgroundColor('#F8F8F8')
    .border({ width: 1, color: '#EFEFEF', style: BorderStyle.Solid })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  AccessPointsList() {
    Column() {
      Text('My Access Points')
        .fontColor('#424242')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)
        .width('100%')
        .margin({ bottom: 16 })

      // Item 1: Main Entrance
      this.AccessPointRow('Main Entrance', '2h ago', false)

      // Item 2: Garage Door
      this.AccessPointRow('Garage Door', '12m ago', true)

      // Item 3: Server Room
      this.AccessPointRow('Server Room', 'Yesterday', false)
    }
  }

  @Builder
  AccessPointRow(title: string, time: string, isActive: boolean) {
    Row() {
      // Left Icon Box
      Row() {
        Image($r('app.media.ic_home')) // Placeholder for Home Icon
          .width(20)
          .height(20)
          .fillColor('#212121')
      }
      .width(40)
      .height(40)
      .borderRadius(10)
      .backgroundColor('#FAFAFA')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(title)
          .fontColor('#212121')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
        
        Text(time)
          .fontColor('#BDBDBD')
          .fontSize(14)
          .margin({ top: 4 })
      }
      .margin({ left: 16 })

      Blank().layoutWeight(1)

      // Custom Switch Component
      this.CustomSwitch(isActive)
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid })
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 12 })
  }

  @Builder
  CustomSwitch(isOn: boolean) {
    Row() {
      if (isOn) {
        // Thumb position when ON (Right side)
        Blank().width(32) 
        Circle({ width: 20, height: 20 })
          .fill(Color.White)
          .shadow({ radius: 2, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
      } else {
        // Thumb position when OFF (Left side)
        Circle({ width: 20, height: 20 })
          .fill('#9E9E9E')
          .shadow({ radius: 2, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
        Blank().width(32)
      }
    }
    .width(52)
    .height(32)
    .borderRadius(16)
    .backgroundColor(isOn ? '#212121' : '#EEEEEE')
    .justifyContent(FlexAlign.Start)
    .onClick(() => {
      // Logic to toggle state would go here if passed down
    })
  }

  @Builder
  ActivityLog() {
    Column() {
      Text('Recent Activity')
        .fontColor('#424242')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)
        .width('100%')
        .margin({ bottom: 16 })

      this.ActivityItem('10:42 AM', 'Main Gate unlocked', 'You')
      this.ActivityItem('09:15 AM', 'Guest Entry Denied', 'System')
      this.ActivityItem('08:30 AM', 'Garage Door opened', 'Alice')
    }
  }

  @Builder
  ActivityItem(time: string, event: string, user: string) {
    Row() {
      Text(time)
        .fontColor('#9E9E9E')
        .fontSize(14)
        .width(70)

      Divider()
        .vertical(true)
        .height(20)
        .color('#EEEEEE')
        .margin({ left: 16, right: 16 })

      Column() {
        Text(event)
          .fontColor('#212121')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        
        Text(`by ${user}`)
          .fontColor('#9E9E9E')
          .fontSize(12)
          .margin({ top: 2 })
      }
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}