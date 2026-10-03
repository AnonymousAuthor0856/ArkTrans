// index.ets
import { Length } from '@ohos.arkui.component';

@Entry
@Component
struct TaskDashboardScreen {
  private categories: string[] = ['All', 'Work', 'Personal', 'Design'];
  @State selectedCategory: string = 'All';

  @Builder
  TopHeader() {
    Row() {
      // Menu Button
      Button() {
        Image($r('sys.media.ohos_ic_public_drawer'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
      .padding(0)

      // Search Button
      Button() {
        Image($r('sys.media.ohos_ic_public_search_filled'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
      .padding(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ top: 48, bottom: 16, left: 24, right: 24 })
  }

  @Builder
  WelcomeSection() {
    Column() {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor('#808080')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategorySelector() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedCategory === category ? '#FFFFFF' : '#000000')
            .backgroundColor(this.selectedCategory === category ? '#212121' : '#F5F5F5')
            .borderRadius(50)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .onClick(() => {
              this.selectedCategory = category;
            })
        })
      }
      .padding({ horizontal: 24 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  TaskItem(
    title: string,
    time: string,
    tag: string,
    tagColor: string,
    tagTextColor: string,
    isChecked: boolean,
    iconResource: Resource
  ) {
    Row() {
      // Icon Box
      Column() {
        Image(iconResource)
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(14)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // Title and Time Column
      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(isChecked ? '#808080' : '#000000')

        Row() {
          Text(time)
            .fontSize(12)
            .fontColor('#808080')

          Text(tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(tagTextColor)
            .backgroundColor(tagColor)
            .borderRadius(4)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .margin({ left: 8 })
        }
        .margin({ top: 4 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      // Checkbox
      Checkbox()
        .select(isChecked)
        .selectedColor('#000000')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  RecentTasksList() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Column({ space: 16 }) {
        this.TaskItem(
          'Team Meeting',
          '10:00 AM - 11:30 AM',
          'Work',
          '#E3F2FD',
          '#1565C0',
          true,
          $r('sys.media.ohos_ic_public_calendar')
        )
        this.TaskItem(
          'Design Review',
          '02:00 PM - 03:00 PM',
          'Design',
          '#F3E5F5',
          '#7B1FA2',
          false,
          $r('sys.media.ohos_ic_public_calendar')
        )
        this.TaskItem(
          'Grocery Shopping',
          '05:30 PM',
          'Personal',
          '#E8F5E9',
          '#2E7D32',
          false,
          $r('sys.media.ohos_ic_public_contacts')
        )
        this.TaskItem(
          'Read Documentation',
          '08:00 PM',
          'Study',
          '#FFF3E0',
          '#EF6C00',
          false,
          $r('sys.media.ohos_ic_public_calendar')
        )
      }
    }
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Top App Bar
        this.TopHeader()

        Scroll() {
          Column() {
            // Content
            Column() {
              this.WelcomeSection()

              // Category Selector
              Column() {
                this.CategorySelector()
              }
              .margin({ top: 32 })

              // Recent Tasks
              Column() {
                this.RecentTasksList()
              }
              .margin({ top: 24 })
            }
            .padding({ left: 0, right: 0, bottom: 100 }) // Extra padding for FAB
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
        .padding({ left: 24, right: 24 })
      }

      // Floating Action Button
      Button() {
        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .fillColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .backgroundColor('#212121')
      .borderRadius(28)
      .position({ x: '100% - 80', y: '100% - 80' })
      .padding(0)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}