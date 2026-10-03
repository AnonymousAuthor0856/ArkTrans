import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct TaskDashboardScreen {
  @State selectedCategory: string = 'All';
  categories: string[] = ['All', 'Work', 'Personal', 'Design'];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Top Header
        Row() {
          Button() {
            Text('☰')
              .fontSize(20)
              .fontColor('#000000')
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#F5F5F5')
          .type(ButtonType.Normal)

          Blank()

          Button() {
            Text('🔍')
              .fontSize(18)
              .fontColor('#000000')
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#F5F5F5')
          .type(ButtonType.Normal)
        }
        .width('100%')
        .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        // Scrollable Content
        Scroll() {
          Column({ space: 0 }) {
            // Welcome Section
            Column({ space: 8 }) {
              Text('Hello, Alex')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .alignSelf(ItemAlign.Start)

              Text('You have 5 incomplete tasks today.')
                .fontSize(16)
                .fontColor('#888888')
                .alignSelf(ItemAlign.Start)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 16 })

            // Category Selector
            Scroll() {
              Row({ space: 12 }) {
                ForEach(this.categories, (category: string) => {
                  Text(category)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedCategory === category ? '#FFFFFF' : '#000000')
                    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                    .backgroundColor(this.selectedCategory === category ? '#212121' : '#F5F5F5')
                    .borderRadius(50)
                    .onClick(() => {
                      this.selectedCategory = category;
                    })
                })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .margin({ top: 32 })

            // Recent Tasks
            Column({ space: 16 }) {
              Text('Recent Tasks')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .alignSelf(ItemAlign.Start)
                .width('100%')

              TaskItemComponent({
                title: 'Team Meeting',
                time: '10:00 AM - 11:30 AM',
                tag: 'Work',
                tagBgColor: '#E3F2FD',
                tagTextColor: '#1565C0',
                isChecked: true,
                iconText: '📅'
              })

              TaskItemComponent({
                title: 'Design Review',
                time: '02:00 PM - 03:00 PM',
                tag: 'Design',
                tagBgColor: '#F3E5F5',
                tagTextColor: '#7B1FA2',
                isChecked: false,
                iconText: '📅'
              })

              TaskItemComponent({
                title: 'Grocery Shopping',
                time: '05:30 PM',
                tag: 'Personal',
                tagBgColor: '#E8F5E9',
                tagTextColor: '#2E7D32',
                isChecked: false,
                iconText: '😊'
              })

              TaskItemComponent({
                title: 'Read Documentation',
                time: '08:00 PM',
                tag: 'Study',
                tagBgColor: '#FFF3E0',
                tagTextColor: '#EF6C00',
                isChecked: false,
                iconText: '📅'
              })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 24 })

            // Bottom padding for FAB
            Column()
              .height(80)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      .alignItems(HorizontalAlign.Start)

      // FAB
      Button() {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#212121')
      .type(ButtonType.Normal)
      .shadow({ radius: 8, color: '#44000000', offsetY: 4 })
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TaskItemComponent {
  @Prop title: string;
  @Prop time: string;
  @Prop tag: string;
  @Prop tagBgColor: string;
  @Prop tagTextColor: string;
  @State isChecked: boolean = false;
  @Prop iconText: string;

  aboutToAppear() {
  }

  build() {
    Row({ space: 16 }) {
      // Icon Box
      Stack() {
        Column()
          .width(48)
          .height(48)
          .borderRadius(14)
          .backgroundColor('#FFFFFF')

        Text(this.iconText)
          .fontSize(22)
      }
      .width(48)
      .height(48)

      // Text Content
      Column({ space: 4 }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#888888' : '#000000')
          .decoration(this.isChecked ? { type: TextDecorationType.LineThrough, color: '#888888' } : { type: TextDecorationType.None })
          .alignSelf(ItemAlign.Start)

        Row({ space: 8 }) {
          Text(this.time)
            .fontSize(12)
            .fontColor('#888888')

          Text(this.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.tagTextColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(this.tagBgColor)
            .borderRadius(4)
        }
        .alignSelf(ItemAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Checkbox
      Text(this.isChecked ? '☑' : '☐')
        .fontSize(24)
        .fontColor(this.isChecked ? '#000000' : '#888888')
        .onClick(() => {
          this.isChecked = !this.isChecked;
        })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}