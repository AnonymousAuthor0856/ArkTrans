import { BusinessError } from '@kit.BasicServicesKit'
import { common, UIAbility, Want } from '@kit.AbilityKit'
import { window } from '@kit.ArkUI'

@Entry
@Component
struct CryoGenApp {
  @State isLocked: boolean = true
  private logs: LogEntry[] = [
    { time: "08:00 AM", message: "Auto-Cycle Complete", isSystem: true },
    { time: "07:45 AM", message: "Pressure stabilized", isSystem: true },
    { time: "06:30 AM", message: "Technician access", isSystem: false },
    { time: "02:15 AM", message: "Nitrogen refill", isSystem: true },
    { time: "Yesterday", message: "System Reboot", isSystem: true }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Column() {
          Text("UNIT-04")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#757575')
          Text("CryoGen Monitor")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#212121')
        }
        Blank()
        Button() {
          Image($r('app.media.settings'))
            .width(24)
            .height(24)
            .fillColor('#212121')
        }
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {})
      }
      .width('100%')
      .padding({ top: 24, bottom: 12, left: 24, right: 24 })
      .height(56)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)

      // Main Content Area
      Column() {
        Spacer().height(16)

        // Status Header
        Row() {
          Image($r('app.media.check'))
            .width(16)
            .height(16)
            .fillColor('#388E3C')
          Spacer().width(8)
          Text("SYSTEM NOMINAL")
            .fontColor('#388E3C')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
        }
        .border({ width: 1, color: '#388E3C', radius: 50 })
        .borderColor('#388E3C')
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })

        Spacer().height(32)

        // Big Temperature Display
        Column() {
          Text("CORE TEMPERATURE")
            .fontSize(12)
            .fontColor('#757575')
            .fontWeight(FontWeight.Medium)
          Row() {
            Text("-184.2")
              .fontSize(64)
              .fontWeight(FontWeight.Lighter)
              .fontColor('#212121')
              .letterSpacing(-2)
            Text("°C")
              .fontSize(24)
              .fontWeight(FontWeight.Normal)
              .fontColor('#757575')
              .margin({ bottom: 12, left: 4 })
          }
          .verticalCenter(VerticalAlign.Bottom)
        }
        .alignItems(HorizontalAlign.Start)

        Spacer().height(32)

        // Grid of Sensor Cards
        Column() {
          Row() {
            SensorCardComponent({
              title: "PRESSURE",
              value: "1.02",
              unit: "Bar",
              iconPath: $r('app.media.info'),
              isWarning: false
            })
            .layoutWeight(1)
            Spacer().width(12)
            SensorCardComponent({
              title: "O2 LEVEL",
              value: "19.5",
              unit: "%",
              iconPath: $r('app.media.warning'),
              isWarning: true
            })
            .layoutWeight(1)
          }
          .width('100%')
          Spacer().height(12)
          Row() {
            SensorCardComponent({
              title: "POWER",
              value: "Stable",
              unit: "AC",
              iconPath: $r('app.media.build'),
              isWarning: false
            })
            .layoutWeight(1)
            Spacer().width(12)
            SensorCardComponent({
              title: "LIQUID N2",
              value: "88",
              unit: "%",
              iconPath: $r('app.media.refresh'),
              isWarning: false
            })
            .layoutWeight(1)
          }
          .width('100%')
        }
        .gap(12)

        Spacer().height(24)

        // Activity Log Title
        Text("MAINTENANCE LOG")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
          .letterSpacing(1.5)
        Spacer().height(8)

        // Scrollable Log List
        List({ space: 8 }) {
          ForEach(this.logs, (log: LogEntry) => {
            ListItem() {
              Row() {
                Column() {
                  if (log.isSystem) {
                    Image($r('app.media.refresh'))
                      .width(16)
                      .height(16)
                      .fillColor('#757575')
                  } else {
                    Image($r('app.media.person'))
                      .width(16)
                      .height(16)
                      .fillColor('#757575')
                  }
                }
                .width(32)
                .height(32)
                .backgroundColor('#F5F5F5')
                .borderRadius(16)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)

                Spacer().width(12)

                Column() {
                  Text(log.message)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#212121')
                  Text(log.time)
                    .fontSize(11)
                    .fontColor('#757575')
                }
              }
              .width('100%')
              .padding({ top: 4, bottom: 4 })
              .alignItems(VerticalAlign.Center)
            }
          }, (log: LogEntry) => log.time + log.message)
        }
        .width('100%')
        .layoutWeight(1)
        .divider({ strokeWidth: 1, color: '#F5F5F5' })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .layoutWeight(1)

      // Bottom Control Bar
      Row() {
        Column() {
          Text("MANUAL OVERRIDE")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#757575')
          Text(this.isLocked ? "LOCKED" : "ACTIVE")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? '#212121' : '#D32F2F')
        }
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn
          })
          .width(50)
          .height(30)
          .selectedColor('#D32F2F')
      }
      .width('100%')
      .padding(24)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .shadow({ radius: 12, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

interface LogEntry {
  time: string;
  message: string;
  isSystem: boolean;
}

@Component
struct SensorCardComponent {
  @Prop title: string
  @Prop value: string
  @Prop unit: string
  @Prop iconPath: Resource
  @Prop isWarning: boolean

  build() {
    Column() {
      Row() {
        Image(this.iconPath)
          .width(20)
          .height(20)
          .fillColor(this.isWarning ? '#D32F2F' : '#0066CC')
        Blank()
        if (this.isWarning) {
          Circle({ width: 6, height: 6 })
            .fill('#D32F2F')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Spacer().height(12)

      Column() {
        Text(this.value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212121')
        Text(`${this.unit}  ${this.title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}