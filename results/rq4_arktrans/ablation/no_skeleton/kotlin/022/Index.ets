@Entry
@Component
struct ProjectTimeline {
  @State notificationsEnabled: boolean = true

  build() {
    Column() {
      // === Header ===
      Text('Project Timeline')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ bottom: 16 })

      // === Notifications Row ===
      Row() {
        Text('Notifications')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
        
        Blank()
        
        Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
          .onChange((isOn: boolean) => {
            this.notificationsEnabled = isOn
          })
          .selectedColor('#38BDF8')
      }
      .width('100%')
      .margin({ bottom: 16 })

      // === Task List ===
      Column({ space: 12 }) {
        // Design Phase
        Column() {
          Text('Design Phase')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#38BDF8')
          
          Progress({ value: 80, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#6366F1')
            .backgroundColor('#E2E8F0')
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })

        // Development
        Column() {
          Text('Development')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#38BDF8')
          
          Progress({ value: 50, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#6366F1')
            .backgroundColor('#E2E8F0')
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })

        // Testing
        Column() {
          Text('Testing')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#38BDF8')
          
          Progress({ value: 30, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#6366F1')
            .backgroundColor('#E2E8F0')
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })

        // Documentation
        Column() {
          Text('Documentation')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#38BDF8')
          
          Progress({ value: 60, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#6366F1')
            .backgroundColor('#E2E8F0')
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })

        // Deployment
        Column() {
          Text('Deployment')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#38BDF8')
          
          Progress({ value: 20, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#6366F1')
            .backgroundColor('#E2E8F0')
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
      }
      .layoutWeight(1)
      .margin({ top: 16, bottom: 16 })

      // === Add Task Button ===
      Button('Add Task')
        .width('100%')
        .height(52)
        .backgroundColor('#38BDF8')
        .fontColor('#FFFFFF')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(16)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F1F5F9')
  }
}