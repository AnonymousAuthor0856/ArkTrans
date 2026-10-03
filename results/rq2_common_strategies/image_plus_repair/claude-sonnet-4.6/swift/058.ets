// AppTokens
const colorPrimary: string = '#111827';
const colorSecondary: string = '#374151';
const colorTertiary: string = '#6B7280';
const colorBackground: string = '#F9FAFB';
const colorSurface: string = '#FFFFFF';
const colorSurfaceVariant: string = '#E5E7EB';
const colorOutline: string = '#D1D5DB';
const colorSuccess: string = '#16A34A';
const colorWarning: string = '#F59E0B';
const colorError: string = '#EF4444';
const colorOnPrimary: string = '#FFFFFF';
const colorOnSecondary: string = '#FFFFFF';
const colorOnTertiary: string = '#111827';
const colorOnBackground: string = '#111827';
const colorOnSurface: string = '#1F2937';

const spacingXs: number = 4;
const spacingSm: number = 8;
const spacingMd: number = 12;
const spacingLg: number = 16;
const spacingXl: number = 24;
const spacingXxl: number = 36;

const shapeSmall: number = 8;
const shapeMedium: number = 12;
const shapeLarge: number = 16;

@Component
struct OverviewPage {
  build() {
    Column({ space: spacingMd }) {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(colorOnSurface)

      Blank().height(spacingLg)

      Button('Sync Device')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(colorOnPrimary)
        .width('60%')
        .height(48)
        .backgroundColor(colorPrimary)
        .borderRadius(shapeLarge)

      Blank()
    }
    .padding(spacingLg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(colorSurface)
  }
}

@Component
struct RankingPage {
  private rankItems: number[] = [0, 1, 2, 3, 4];

  build() {
    Column({ space: spacingSm }) {
      ForEach(this.rankItems, (it: number) => {
        Row() {
          Text(`User ${it + 1}`)
            .fontColor(colorOnSurface)
            .fontSize(14)
            .fontWeight(FontWeight.Regular)

          Blank()

          Text(`${9000 - it * 500} steps`)
            .fontColor(colorOnSurface)
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
        }
        .padding(spacingMd)
        .backgroundColor(colorSurfaceVariant)
        .borderRadius(shapeMedium)
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      })
    }
    .padding(spacingLg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(colorSurface)
  }
}

@Component
struct StatsPage {
  private barItems: number[] = [0, 1, 2, 3, 4, 5, 6];

  build() {
    Column({ space: spacingSm }) {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(colorOnSurface)

      ForEach(this.barItems, (it: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(20)
            .backgroundColor(colorSurfaceVariant)
            .borderRadius(shapeSmall)

          Row()
            .width(`${Math.min((0.3 + it * 0.1) * 100, 100)}%`)
            .height(20)
            .backgroundColor(colorPrimary)
            .borderRadius(shapeSmall)
        }
        .width('100%')
        .height(20)
      })

      Blank()
    }
    .padding(spacingLg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(colorSurface)
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];
  private controller: TabsController = new TabsController();

  build() {
    Column({ space: 0 }) {
      // Title
      Text('Step Challenge')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(colorOnBackground)
        .padding(spacingLg)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(colorSurfaceVariant)

      // Custom Tab Row
      Column({ space: 0 }) {
        Row({ space: 0 }) {
          ForEach(this.tabs, (tab: string, index: number) => {
            Button(tab)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTabIndex === index ? colorPrimary : colorOnSurface)
              .backgroundColor(Color.Transparent)
              .padding({ top: spacingMd, bottom: spacingMd })
              .layoutWeight(1)
              .onClick(() => {
                this.selectedTabIndex = index;
                this.controller.changeIndex(index);
              })
          })
        }
        .width('100%')

        // Indicator
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(2)
            .backgroundColor(colorSurfaceVariant)

          Row()
            .width(`${100 / this.tabs.length}%`)
            .height(2)
            .backgroundColor(colorPrimary)
            .translate({ x: `${(100 / this.tabs.length) * this.selectedTabIndex}%` })
            .animation({
              duration: 200,
              curve: Curve.EaseInOut,
            })
        }
        .width('100%')
        .height(2)
      }
      .width('100%')
      .backgroundColor(colorSurface)

      // Tab Content
      Tabs({ barPosition: BarPosition.Start, controller: this.controller, index: this.selectedTabIndex }) {
        TabContent() {
          OverviewPage()
        }
        .tabBar('')

        TabContent() {
          RankingPage()
        }
        .tabBar('')

        TabContent() {
          StatsPage()
        }
        .tabBar('')
      }
      .barHeight(0)
      .animationDuration(300)
      .onChange((index: number) => {
        this.selectedTabIndex = index;
      })
      .layoutWeight(1)
      .backgroundColor(colorSurface)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[colorSurfaceVariant, 0.0], [colorSurface, 1.0]]
    })
  }
}