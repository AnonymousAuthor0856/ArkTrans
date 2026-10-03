@Entry
@Component
struct Index {
  @State categories: string[] = ['All', 'Work', 'Personal']
  @State selectedCategoryIndex: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Main Content Column ===
      Column({ space: 0 }) {
        // Spacer top
        Blank().height(16)

        // Welcome Section
        Column({ space: 8 }) {
          Text('Hello, Alex')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Text('You have 5 incomplete tasks today.')
            .fontSize(16)
            .fontColor('#9E9E9E')
        }

        // Spacer
        Blank().height(32)

        // Category Selector (Horizontal List)
        List({ space: 12 }) {
          ForEach(this.categories, (category: string, index: number) => {
            ListItem() {
              Button(category)
                .type(ButtonType.Normal)
                .backgroundColor(index === this.selectedCategoryIndex ? '#000000' : '#F5F5F5')
                .fontColor(index === this.selectedCategoryIndex ? '#FFFFFF' : '#000000')
                .borderRadius(50)
                .width('auto')
                .height(48)
                .padding({ left: 24, right: 24 })
                .onClick(() => {
                  this.selectedCategoryIndex = index
                })
            }
          })
        }
        .listDirection(Axis.Horizontal)
        .width('100%')
        .layoutWeight(0) // Don't expand vertically

        // Spacer
        Blank().height(24)

        // Recent Tasks Header
        Text('Recent Tasks')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ bottom: 16 })

        // Recent Tasks List (Vertical List)
        List({ space: 16 }) {
          // Task Item 1: Team Meeting
          ListItem() {
            Row({ space: 12 }) {
              // Icon Box
              Row() {
                Image($r('app.media.startIcon')) // Using placeholder as per rules
                  .width(24)
                  .height(24)
                  .objectFit(ImageFit.Contain)
              }
              .width(48)
              .height(48)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)

              // Content
              Column({ space: 4 }) {
                Text('Team Meeting')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#757575') // Greyed out based on screenshot style for completed/old? Or just title. Screenshot shows grey text for title "Team Meeting" but black for "Design Review". Let's stick to standard black/grey hierarchy. Actually, looking closely at screenshot: "Team Meeting" is grey (#757575), "Design Review" is black (#000000).
                
                Text('10:00 AM - 11:30 AM')
                  .fontSize(14)
                  .fontColor('#9E9E9E')
              }
              .layoutWeight(1)

              // Tag
              Text('Work')
                .fontSize(12)
                .fontColor('#0000FF') // Blueish tint from screenshot
                .backgroundColor('#E3F2FD')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .borderRadius(4)

              // Checkbox/Action
              Image($r('app.media.startIcon')) // Placeholder for check icon
                .width(24)
                .height(24)
                .backgroundColor('#000000')
                .borderRadius(4)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FAFAFA')
            .borderRadius(16)
          }

          // Task Item 2: Design Review
          ListItem() {
            Row({ space: 12 }) {
              // Icon Box
              Row() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .objectFit(ImageFit.Contain)
              }
              .width(48)
              .height(48)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)

              // Content
              Column({ space: 4 }) {
                Text('Design Review')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
                
                Text('02:00 PM - 03:00 PM')
                  .fontSize(14)
                  .fontColor('#9E9E9E')
              }
              .layoutWeight(1)

              // Tag
              Text('Design')
                .fontSize(12)
                .fontColor('#800080') // Purple tint
                .backgroundColor('#F3E5F5')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .borderRadius(4)

              // Checkbox/Action (Unchecked)
              Row() {
                // Simple square border for unchecked
              }
              .width(24)
              .height(24)
              .border({ width: 2, color: '#9E9E9E' })
              .borderRadius(4)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FAFAFA')
            .borderRadius(16)
          }
          
          // Spacer to allow scrolling past the FAB if needed, or just visual padding
          ListItem() {
             Column() {
               Blank().height(100)
             }
          }
        }
        .width('100%')
        .layoutWeight(1) // Take remaining space
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })

      // === Top Header (Absolute Positioned) ===
      Row({ space: 0 }) {
        // Menu Button
        Button() {
          Image($r('app.media.startIcon')) // Placeholder for menu icon
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .type(ButtonType.Circle)
        .backgroundColor('#F5F5F5')
        .width(48)
        .height(48)

        Blank().layoutWeight(1)

        // Search Button
        Button() {
          Image($r('app.media.startIcon')) // Placeholder for search icon
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .type(ButtonType.Circle)
        .backgroundColor('#F5F5F5')
        .width(48)
        .height(48)
      }
      .width('100%')
      .padding({ top: 48, left: 24, right: 24, bottom: 16 })
      .position({ x: 0, y: 0 })

      // === Floating Action Button ===
      Button() {
        Image($r('app.media.startIcon')) // Placeholder for Add icon
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor('#FFFFFF')
      }
      .type(ButtonType.Circle)
      .backgroundColor('#212121')
      .width(56)
      .height(56)
      .shadow({ radius: 8, color: '#000000', offsetX: 0, offsetY: 4 })
      .position({ x: 'calc(100% - 52vp)', y: 'calc(100% - 52vp)' }) // Approximate positioning based on screen size logic, usually fixed bottom-right
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}