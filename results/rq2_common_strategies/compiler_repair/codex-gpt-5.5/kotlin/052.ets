class MonoColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#444444';
  static readonly background: string = '#F5F5F5';
  static readonly surface: string = '#FFFFFF';
  static readonly outline: string = '#CCCCCC';
  static readonly onPrimary: string = '#FFFFFF';
}

@Entry
@Component
struct Index {
  @State selectedTab: number = 0;
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];

  private listTitle(): string {
    if (this.selectedTab === 0) {
      return 'All Courses';
    }
    if (this.selectedTab === 1) {
      return 'Enrolled';
    }
    return 'Completed';
  }

  private courseCount(): number {
    if (this.selectedTab === 0) {
      return 6;
    }
    if (this.selectedTab === 1) {
      return 3;
    }
    return 4;
  }

  @Builder
  Tabs() {
    Row() {
      ForEach(this.tabs, (title: string, index: number) => {
        Button(title)
          .height(48)
          .fontSize(this.selectedTab === index ? 18 : 14)
          .fontWeight(this.selectedTab === index ? FontWeight.Bold : FontWeight.Normal)
          .fontColor(this.selectedTab === index ? MonoColors.primary : MonoColors.secondary)
          .backgroundColor(MonoColors.surface)
          .borderRadius(0)
          .layoutWeight(1)
          .border({ width: { bottom: this.selectedTab === index ? 3 : 1 }, color: this.selectedTab === index ? MonoColors.primary : MonoColors.outline })
          .onClick(() => {
            this.selectedTab = index;
          })
      }, (title: string) => title)
    }
    .width('100%')
    .backgroundColor(MonoColors.surface)
  }

  @Builder
  CourseRow(index: number) {
    Row() {
      Column() {
        Text('Course ' + (index + 1).toString())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(MonoColors.primary)
        Text('Duration: ' + (5 + index).toString() + ' hrs')
          .fontSize(14)
          .fontColor(MonoColors.secondary)
          .margin({ top: 8 })
      }
      .layoutWeight(1)

      Text('View')
        .height(24)
        .fontSize(14)
        .fontColor(MonoColors.onPrimary)
        .backgroundColor(MonoColors.primary)
        .borderRadius(12)
        .padding({ left: 12, right: 12 })
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(12)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(MonoColors.surface)
    .borderRadius(10)
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  CourseList() {
    Column() {
      Text(this.listTitle())
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(MonoColors.secondary)
        .width('100%')
        .margin({ bottom: 12 })

      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        if (index < this.courseCount()) {
          Column() {
            this.CourseRow(index)
          }
          .margin({ bottom: 12 })
        }
      }, (index: number) => index.toString())
    }
    .width('100%')
  }

  build() {
    Column() {
      Text('Course Catalog')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(MonoColors.primary)
        .width('100%')
        .margin({ bottom: 12 })

      this.Tabs()

      Scroll() {
        Column() {
          this.CourseList()
        }
        .width('100%')
        .padding({ top: 12, bottom: 16 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16, top: 12 })
    .backgroundColor(MonoColors.background)
  }
}
