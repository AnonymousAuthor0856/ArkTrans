import window from '@ohos.window';

class ColorTokens {
  readonly primary: ResourceColor = '#0EA5E9';
  readonly secondary: ResourceColor = '#6366F1';
  readonly tertiary: ResourceColor = '#06B6D4';
  readonly background: ResourceColor = '#F1F5F9';
  readonly surface: ResourceColor = '#FFFFFF';
  readonly surfaceVariant: ResourceColor = '#E2E8F0';
  readonly outline: ResourceColor = '#D1D5DB';
  readonly success: ResourceColor = '#10B981';
  readonly warning: ResourceColor = '#F59E0B';
  readonly error: ResourceColor = '#EF4444';
  readonly onPrimary: ResourceColor = '#FFFFFF';
  readonly onSecondary: ResourceColor = '#FFFFFF';
  readonly onTertiary: ResourceColor = '#0F172A';
  readonly onBackground: ResourceColor = '#1E293B';
  readonly onSurface: ResourceColor = '#1E293B';
}

class TextStyleToken {
  size: number;
  weight: number | FontWeight | string;

  constructor(size: number, weight: number | FontWeight | string) {
    this.size = size;
    this.weight = weight;
  }
}

class TypographyTokenSet {
  readonly display: TextStyleToken = new TextStyleToken(26, 700);
  readonly headline: TextStyleToken = new TextStyleToken(18, 600);
  readonly title: TextStyleToken = new TextStyleToken(14, 500);
  readonly body: TextStyleToken = new TextStyleToken(12, 400);
  readonly label: TextStyleToken = new TextStyleToken(11, 500);
}

class ShapeTokens {
  readonly small: number = 6;
  readonly medium: number = 10;
  readonly large: number = 14;
}

class SpacingTokens {
  readonly xs: number = 2;
  readonly sm: number = 6;
  readonly md: number = 10;
  readonly lg: number = 14;
  readonly xl: number = 20;
  readonly xxl: number = 28;
}

class ShadowSpec {
  radius: number;
  x: number;
  y: number;
  opacity: number;

  constructor(radius: number, x: number, y: number, opacity: number) {
    this.radius = radius;
    this.x = x;
    this.y = y;
    this.opacity = opacity;
  }
}

class ElevationTokenSet {
  readonly level1: ShadowSpec = new ShadowSpec(2, 0, 1, 0.1);
  readonly level2: ShadowSpec = new ShadowSpec(4, 0, 2, 0.14);
  readonly level3: ShadowSpec = new ShadowSpec(6, 0, 3, 0.16);
}

class AppTokens {
  static readonly Colors: ColorTokens = new ColorTokens();
  static readonly TypographyTokens: TypographyTokenSet = new TypographyTokenSet();
  static readonly Shapes: ShapeTokens = new ShapeTokens();
  static readonly Spacing: SpacingTokens = new SpacingTokens();
  static readonly ElevationMapping: ElevationTokenSet = new ElevationTokenSet();
}

class Homework {
  id: number;
  title: string;
  status: string;

  constructor(id: number, title: string, status: string) {
    this.id = id;
    this.title = title;
    this.status = status;
  }
}

class ChartData {
  id: number;
  label: string;
  progress: number;

  constructor(id: number, label: string, progress: number) {
    this.id = id;
    this.label = label;
    this.progress = progress;
  }
}

@Component
struct AssignmentCard {
  homework: Homework = new Homework(0, '', '');

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Blank()
        .width(40)
        .height(40)
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Shapes.small)

      Text(this.homework.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)

      Text(this.homework.status)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)
    .padding(AppTokens.Spacing.md)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.medium
    })
  }
}

@Component
struct ChartProgressBar {
  chartData: ChartData = new ChartData(0, '', 0);

  build() {
    Column({ space: 0 }) {
      Stack({ alignContent: Alignment.Start }) {
        Blank()
          .width('100%')
          .height(24)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

        Blank()
          .width(`${this.chartData.progress * 100}%`)
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .height(24)

      Text(`${this.chartData.label}: ${Math.floor(this.chartData.progress * 100)}%`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct RootScreen {
  private works: Homework[] = [
    new Homework(1, 'Linear Algebra HW1', 'Submitted'),
    new Homework(2, 'Data Structures HW2', 'Pending'),
    new Homework(3, 'Algorithm HW3', 'Graded'),
    new Homework(4, 'Probability HW4', 'Pending')
  ];

  @State private charts: ChartData[] = [
    new ChartData(1, 'Week 1', 0.7),
    new ChartData(2, 'Week 2', 0.9),
    new ChartData(3, 'Week 3', 0.5),
    new ChartData(4, 'Week 4', 0.8)
  ];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowSystemBarEnable([]);
      })
      .catch(() => {
      });
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Row() {
          Text('Homework Submit')
            .fontSize(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .width('100%')
        .padding({
          top: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.lg
        })
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)

        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            Text('Assignments')
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onBackground)

            Grid() {
              ForEach(this.works, (item: Homework) => {
                GridItem() {
                  AssignmentCard({ homework: item })
                }
              }, (item: Homework) => item.id.toString())
            }
            .width('100%')
            .columnsTemplate('1fr 1fr')
            .columnsGap(AppTokens.Spacing.md)
            .rowsGap(AppTokens.Spacing.md)
            .padding({ bottom: AppTokens.Spacing.lg })

            Text('Progress Chart')
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onBackground)

            Column({ space: AppTokens.Spacing.sm }) {
              ForEach(this.charts, (item: ChartData) => {
                ChartProgressBar({ chartData: item })
              }, (item: ChartData) => item.id.toString())
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Button({ type: ButtonType.Normal }) {
              Text('Submit New HW')
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.onSecondary)
                .width('100%')
                .textAlign(TextAlign.Center)
            }
            .width('60%')
            .height(40)
            .margin({ top: AppTokens.Spacing.lg })
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .alignSelf(ItemAlign.Center)
            .onClick(() => {
              console.info('Submit New HW Tapped');
            })
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['rgba(14, 165, 233, 0.15)', 0.0],
            ['rgba(99, 102, 241, 0.10)', 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}