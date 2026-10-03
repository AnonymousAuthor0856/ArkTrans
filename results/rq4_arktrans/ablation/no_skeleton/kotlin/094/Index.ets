@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true
  @State mainEntranceChecked: boolean = false
  @State garageDoorChecked: boolean = true
  @State serverRoomChecked: boolean = false

  build() {
    Column() {
      // === Header Section ===
      Row() {
        Column() {
          Text('Welcome back,')
            .fontColor('#9E9E9E')
            .fontSize(14)
          Text('David Miller')
            .fontWeight(FontWeight.Bold)
            .fontSize(24)
            .margin({ top: 4 })
        }

        Blank()

        Image($r('app.media.startIcon'))
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#F5F5F5')
          .objectFit(ImageFit.Contain)
          .border({ width: 1, color: '#E0E0E0' })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24 })

      // === Spacer ===
      Blank().height(40)

      // === Master Status Card ===
      Column() {
        // Icon Container
        Column() {
          Image($r('app.media.startIcon'))
            .width(36)
            .height(36)
            .objectFit(ImageFit.Contain)
        }
        .width(80)
        .height(80)
        .borderRadius(40)
        .backgroundColor('#FFFFFF')
        .border({ width: 2, color: this.masterLockState ? '#D6D6D6' : '#C8E6C9', style: BorderStyle.Solid })
        .onClick(() => {
          this.masterLockState = !this.masterLockState
        })

        Blank().height(16)

        // Status Text
        Text(this.masterLockState ? 'SECURE' : 'UNLOCKED')
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontSize(24)
          .fontColor(this.masterLockState ? '#212121' : '#4CAF50')

        Blank().height(8)

        // Subtext
        Text(this.masterLockState ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
          .fontColor('#9E9E9E')
          .fontSize(14)
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#F8F8F8')
      .borderRadius(24)
      .border({ width: 1, color: '#EFEFEF', style: BorderStyle.Solid })
      .margin({ left: 24, right: 24 })

      // === Spacer ===
      Blank().height(32)

      // === My Access Points Header ===
      Text('My Access Points')
        .fontWeight(FontWeight.Bold)
        .fontColor('#424242')
        .fontSize(18)
        .margin({ left: 24, right: 24 })

      Blank().height(16)

      // === Access Point List ===
      Column() {
        // Item 1: Main Entrance
        Row() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .objectFit(ImageFit.Contain)
          }
          .width(40)
          .height(40)
          .borderRadius(10)
          .backgroundColor('#FAFAFA')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Blank().width(16)

          Column() {
            Text('Main Entrance')
              .fontWeight(FontWeight.Medium)
              .fontSize(16)
            Text('2h ago')
              .fontColor('#BDBDBD')
              .fontSize(12)
              .margin({ top: 4 })
          }

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.mainEntranceChecked })
            .onChange((isOn: boolean) => {
              this.mainEntranceChecked = isOn
            })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid })
        .margin({ left: 24, right: 24 })

        Blank().height(12)

        // Item 2: Garage Door
        Row() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .objectFit(ImageFit.Contain)
          }
          .width(40)
          .height(40)
          .borderRadius(10)
          .backgroundColor('#FAFAFA')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Blank().width(16)

          Column() {
            Text('Garage Door')
              .fontWeight(FontWeight.Medium)
              .fontSize(16)
            Text('12m ago')
              .fontColor('#BDBDBD')
              .fontSize(12)
              .margin({ top: 4 })
          }

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.garageDoorChecked })
            .onChange((isOn: boolean) => {
              this.garageDoorChecked = isOn
            })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid })
        .margin({ left: 24, right: 24 })

        Blank().height(12)

        // Item 3: Server Room
        Row() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .objectFit(ImageFit.Contain)
          }
          .width(40)
          .height(40)
          .borderRadius(10)
          .backgroundColor('#FAFAFA')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Blank().width(16)

          Column() {
            Text('Server Room')
              .fontWeight(FontWeight.Medium)
              .fontSize(16)
            Text('Yesterday')
              .fontColor('#BDBDBD')
              .fontSize(12)
              .margin({ top: 4 })
          }

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.serverRoomChecked })
            .onChange((isOn: boolean) => {
              this.serverRoomChecked = isOn
            })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid })
        .margin({ left: 24, right: 24 })
      }

      // === Spacer ===
      Blank().height(32)

      // === Recent Activity Header ===
      Text('Recent Activity')
        .fontWeight(FontWeight.Bold)
        .fontColor('#424242')
        .fontSize(18)
        .margin({ left: 24, right: 24 })

      Blank().height(16)

      // === Activity Log Items ===
      Column() {
        // Log Item 1
        Row() {
          Text('10:42 AM')
            .fontColor('#9E9E9E')
            .fontSize(12)
            .width(70)

          Divider()
            .vertical(true)
            .height(20)
            .color('#EEEEEE')

          Blank().width(16)

          Column() {
            Text('Main Gate unlocked')
              .fontWeight(FontWeight.Medium)
              .fontSize(14)
            Text('by You')
              .fontColor('#9E9E9E')
              .fontSize(12)
              .margin({ top: 2 })
          }
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .alignItems(VerticalAlign.Center)

        // Log Item 2
        Row() {
          Text('09:15 AM')
            .fontColor('#9E9E9E')
            .fontSize(12)
            .width(70)

          Divider()
            .vertical(true)
            .height(20)
            .color('#EEEEEE')

          Blank().width(16)

          Column() {
            Text('Guest Entry Denied')
              .fontWeight(FontWeight.Medium)
              .fontSize(14)
            Text('by System')
              .fontColor('#9E9E9E')
              .fontSize(12)
              .margin({ top: 2 })
          }
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .alignItems(VerticalAlign.Center)

        // Log Item 3
        Row() {
          Text('08:30 AM')
            .fontColor('#9E9E9E')
            .fontSize(12)
            .width(70)

          Divider()
            .vertical(true)
            .height(20)
            .color('#EEEEEE')

          Blank().width(16)

          Column() {
            Text('Garage Door opened')
              .fontWeight(FontWeight.Medium)
              .fontSize(14)
            Text('by Alice')
              .fontColor('#9E9E9E')
              .fontSize(12)
              .margin({ top: 2 })
          }
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .alignItems(VerticalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}