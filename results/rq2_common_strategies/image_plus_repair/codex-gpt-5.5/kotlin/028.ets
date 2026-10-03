interface ProductivityItem {
  title: string;
  status: string;
  progress: number;
  color: string;
}

interface ChartItem {
  label: string;
  value: number;
}

interface AppColors {
  primary: string;
  secondary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
}

@Entry
@Component
struct MainPage {
  private readonly colors: AppColors = {
    primary: '#0F172A',
    secondary: '#475569',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0'
  };

  private readonly filters: string[] = ['Daily', 'Weekly', 'Monthly'];
  private readonly chartData: ChartItem[] = [
    { label: 'Mon', value: 0.6 },
    { label: 'Tue', value: 0.8 },
    { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 },
    { label: 'Fri', value: 0.7 },
    { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 }
  ];
  private readonly productivityItems: ProductivityItem[] = [
    { title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, color: '#22C55E' },
    { title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, color: '#F59E0B' },
    { title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, color: '#475569' },
    { title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, color: '#22C55E' },
    { title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, color: '#EF4444' }
  ];

  @State private selectedFilter: string = 'Weekly';

  build() {
    Stack() {
      Column() {
        this.header()
        Scroll() {
          Column({ space: 24 }) {
            this.filterBar()
            this.chartCard()
            ForEach(this.productivityItems, (item: ProductivityItem) => {
              this.productivityCard(item)
            }, (item: ProductivityItem) => item.title)
          }
          .width('100%')
          .padding({ left: 32, right: 32, top: 16, bottom: 128 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        this.bottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.colors.background)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  header() {
    Row() {
      Circle({ width: 48, height: 48 })
        .fill(this.colors.outline)
      Text('Productivity Check')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.primary)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
      Circle({ width: 48, height: 48 })
        .fill(this.colors.outline)
    }
    .width('100%')
    .height(128)
    .padding({ left: 32, right: 32 })
    .backgroundColor(this.colors.surface)
  }

  @Builder
  filterBar() {
    Row({ space: 16 }) {
      ForEach(this.filters, (filter: string) => {
        Button(filter)
          .height(64)
          .width(130)
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedFilter === filter ? '#FFFFFF' : this.colors.primary)
          .backgroundColor(this.selectedFilter === filter ? this.colors.primary : this.colors.surface)
          .border({
            width: 1,
            color: this.colors.outline,
            radius: 14
          })
          .borderRadius(14)
          .onClick(() => {
            this.selectedFilter = filter;
          })
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  chartCard() {
    Column() {
      Text('Weekly Throughput')
        .width('100%')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.primary)
        .textAlign(TextAlign.Start)
      Row() {
        ForEach(this.chartData, (item: ChartItem) => {
          Column() {
            Column() {
              Blank()
                .layoutWeight(1)
              Blank()
                .height(220 * item.value)
                .width(50)
                .backgroundColor(this.colors.primary)
                .borderRadius(16)
            }
            .height(220)
            .width('100%')
            Text(item.label)
              .margin({ top: 12 })
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.secondary)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
        })
      }
      .width('100%')
      .height(290)
      .alignItems(VerticalAlign.Bottom)
      .margin({ top: 24 })
    }
    .width('100%')
    .padding(32)
    .backgroundColor(this.colors.surface)
    .borderRadius(30)
    .border({ width: 1, color: '#E5E7EB' })
    .shadow({
      radius: 4,
      color: '#22000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  productivityCard(item: ProductivityItem) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.primary)
          .layoutWeight(1)
        Row({ space: 12 }) {
          Circle({ width: 20, height: 20 })
            .fill(item.color)
          Text(item.status)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.color)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      Row({ space: 24 }) {
        Progress({
          value: item.progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .layoutWeight(1)
          .height(16)
          .color(item.color)
          .backgroundColor(this.colors.surfaceVariant)
          .borderRadius(8)
        Text(`${Math.round(item.progress * 100)}%`)
          .width(64)
          .fontSize(24)
          .fontColor(this.colors.secondary)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .margin({ top: 28 })
    }
    .width('100%')
    .padding(32)
    .backgroundColor(this.colors.surface)
    .borderRadius(24)
    .border({ width: 1, color: this.colors.outline })
  }

  @Builder
  bottomBar() {
    Column() {
      Button('Submit New Form')
        .width('100%')
        .height(112)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor(this.colors.primary)
        .borderRadius(24)
        .onClick(() => {
          this.selectedFilter = 'Daily';
        })
    }
    .width('100%')
    .padding({ left: 32, right: 32, top: 32, bottom: 32 })
    .backgroundColor('#E5E7EB')
  }
}
