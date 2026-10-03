@Entry
@Component
struct Index {
  @State currentMonth: number = 1 // 0=Jan, 1=Feb, etc.
  @State currentYear: number = 2026

  build() {
    Column() {
      // Header
      Row() {
        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
        }
        .backgroundColor('#EADDFF')
        .borderRadius(30)
        .width(56)
        .height(56)
        
        Text('Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ left: 16 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })

      Scroll() {
        Column() {
          // February Section
          this.renderMonth(1, 2026)
          
          // March Section
          this.renderMonth(2, 2026)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF9F9') // Light pinkish background
  }

  @Builder
  renderMonth(month: number, year: number) {
    Column() {
      Text(this.getMonthName(month) + ' ' + year)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
        .margin({ top: 24, bottom: 8 })
        .alignSelf(ItemAlign.Start)

      // Weekday Headers
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceEvenly }) {
        ForEach(['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'] as string[], (day: string) => {
          Text(day)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#49454F')
            .width(40)
            .textAlign(TextAlign.Center)
        })
      }
      .width('100%')
      .margin({ bottom: 8 })

      // Days Grid
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceEvenly }) {
        // Calculate days for the month
        let daysInMonth: number = new Date(year, month, 0).getDate();
        let firstDayOfWeek: number = new Date(year, month - 1, 1).getDay(); // 0=Sun, 1=Mon...
        
        // Adjust to Mon=0, Sun=6
        let startOffset: number = (firstDayOfWeek === 0) ? 6 : firstDayOfWeek - 1;

        // Empty slots before the 1st
        ForEach(Array.from({ length: startOffset }, (_, i: number) => i) as number[], () => {
          Text('')
            .width(40)
            .height(40)
        })

        // Actual days
        ForEach(Array.from({ length: daysInMonth }, (_, i: number) => i + 1) as number[], (day: number) => {
          Text(day.toString())
            .fontSize(16)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1C1B1F')
            .width(40)
            .height(40)
            .textAlign(TextAlign.Center)
            .justifyContent(FlexAlign.Center)
        })
      }
      .width('100%')
    }
  }

  getMonthName(m: number): string {
    const names: string[] = [
      'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
      'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'
    ];
    return names[m - 1];
  }
}