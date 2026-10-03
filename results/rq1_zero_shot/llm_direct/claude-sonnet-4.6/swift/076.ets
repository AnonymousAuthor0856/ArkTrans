import { router } from '@kit.ArkUI';

@Entry
@Component
struct SmartHomeDashboard {
  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F4F6F8')

      Scroll() {
        Column({ space: 0 }) {
          // Top Header Spacer
          Blank().height(16)

          // Header
          Row() {
            Column({ space: 0 }) {
              Text('Good Morning,')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#888888')
              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Circle()
                .fill(Color.White)
                .width(48)
                .height(48)
              Image($r('app.media.ic_person'))
                .width(24)
                .height(24)
                .fillColor('#000000')
                .objectFit(ImageFit.Contain)
            }
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          // Energy Usage Card
          Row() {
            Column({ space: 0 }) {
              Text('Energy Usage')
                .fontSize(14)
                .fontColor('rgba(255,255,255,0.8)')
              Text('28.5 kWh')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
              Text('Today')
                .fontSize(12)
                .fontColor('rgba(255,255,255,0.6)')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Circle()
                .fill('rgba(255,255,255,0.2)')
                .width(56)
                .height(56)
              Image($r('app.media.ic_bell'))
                .width(24)
                .height(24)
                .fillColor('#FFFFFF')
                .objectFit(ImageFit.Contain)
            }
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#5E60CE')
          .borderRadius(24)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 4 })
          .margin({ left: 24, right: 24 })
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          // Scenes Section Title
          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          // Scenes Horizontal Scroll
          Scroll() {
            Row({ space: 12 }) {
              Blank().width(24)
              SceneButton({ text: 'Home', icon: $r('app.media.ic_home'), isSelected: true })
              SceneButton({ text: 'Away', icon: $r('app.media.ic_lock'), isSelected: false })
              SceneButton({ text: 'Sleep', icon: $r('app.media.ic_star'), isSelected: false })
              Blank().width(24)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Blank().height(32)

          // Devices Section Title
          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          // Devices Grid
          Row({ space: 16 }) {
            Column({ space: 16 }) {
              DeviceCard({
                name: 'Smart Lamp',
                icon: $r('app.media.ic_star'),
                isActive: true,
                accentColor: '#FFC107'
              })
              DeviceCard({
                name: 'Thermostat',
                icon: $r('app.media.ic_menu'),
                isActive: true,
                accentColor: '#FF7043'
              })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Column({ space: 16 }) {
              DeviceCard({
                name: 'Main Lock',
                icon: $r('app.media.ic_lock'),
                isActive: false,
                accentColor: '#4CAF50'
              })
              DeviceCard({
                name: 'Wi-Fi Router',
                icon: $r('app.media.ic_gear'),
                isActive: true,
                accentColor: '#2196F3'
              })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(VerticalAlign.Top)

          Blank().height(24)
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct SceneButton {
  text: string = '';
  icon: Resource = $r('app.media.ic_home');
  isSelected: boolean = false;

  build() {
    Row({ space: 8 }) {
      Image(this.icon)
        .width(18)
        .height(18)
        .fillColor(this.isSelected ? '#FFFFFF' : '#000000')
        .objectFit(ImageFit.Contain)
      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? '#212121' : '#FFFFFF')
    .borderRadius(30)
  }
}

@Component
struct DeviceCard {
  name: string = '';
  icon: Resource = $r('app.media.ic_star');
  isActive: boolean = false;
  accentColor: string = '#000000';
  @State switchState: boolean = false;

  aboutToAppear() {
    this.switchState = this.isActive;
  }

  build() {
    Column({ space: 0 }) {
      // Icon Row
      Row() {
        Stack() {
          Circle()
            .fill(this.switchState ? this.hexToRgba(this.accentColor, 0.1) : '#F0F0F0')
            .width(40)
            .height(40)
          Image(this.icon)
            .width(24)
            .height(24)
            .fillColor(this.switchState ? this.accentColor : '#888888')
            .objectFit(ImageFit.Contain)
        }
        Blank()
      }
      .width('100%')

      Blank().layoutWeight(1)

      // Name and Status
      Column({ space: 4 }) {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accentColor : '#888888')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')

      Blank().layoutWeight(1)

      // Toggle Row
      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .selectedColor(this.accentColor)
          .onChange((isOn: boolean) => {
            this.switchState = isOn;
          })
          .scale({ x: 0.8, y: 0.8 })
      }
      .width('100%')
    }
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 2, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }

  hexToRgba(hex: string, alpha: number): string {
    const r = parseInt(hex.slice(1, 3), 16);
    const g = parseInt(hex.slice(3, 5), 16);
    const b = parseInt(hex.slice(5, 7), 16);
    return `rgba(${r},${g},${b},${alpha})`;
  }
}