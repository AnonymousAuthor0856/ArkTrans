import { TabsController } from '@kit.ArkUI';

interface ColorTokens {
  primary: string;
  secondary: string;
  background: string;
  surface: string;
  outline: string;
  onPrimary: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  body: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
}

interface ElevationLevel {
  blurRadius: number;
  yOffset: number;
  opacity: number;
}

interface ElevationMapping {
  level1: ElevationLevel;
}

export class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#111111',
    secondary: '#444444',
    background: '#F5F5F5',
    surface: '#FFFFFF',
    outline: '#CCCCCC',
    onPrimary: '#FFFFFF',
    onSurface: '#111111'
  }

  static readonly TypographyTokens: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal }
  }

  static readonly Shapes: ShapeTokens = {
    small: 6,
    medium: 10,
    large: 14
  }

  static readonly Spacing: SpacingTokens = {
    sm: 8,
    md: 12,
    lg: 16
  }

  static readonly ElevationMapping: ElevationMapping = {
    level1: { blurRadius: 4, yOffset: 2, opacity: 0.1 }
  }
}

@Component
export struct CourseCard {
  @Prop courseNumber: number;

  build() {
    Column() {
      Row() {
        Column({ space: AppTokens.Spacing.sm }) {
          Text(`Course ${this.courseNumber}`)
            .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
            .fontColor(AppTokens.Colors.primary)
          
          Text(`Duration: ${5 + this.courseNumber - 1} hrs`)
            .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .fontColor(AppTokens.Colors.secondary)
        }
        .alignItems(HorizontalAlign.Start)
        
        Blank()
        
        Text('View')
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 12, right: 12 })
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(12) // Capsule equivalent
      }
      .padding(AppTokens.Spacing.md)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({ radius: AppTokens.ElevationMapping.level1.blurRadius, color: 'rgba(0,0,0,' + AppTokens.ElevationMapping.level1.opacity + ')', offsetY: AppTokens.ElevationMapping.level1.yOffset })
  }
}

interface TabItem {
  tab: string;
  index: number;
}

@Component
export struct CustomTabRow {
  tabs: string[] = [];
  @Link selectedTabIndex: number;

  build() {
    Row() {
      ForEach(this.tabs.map((tab: string, index: number): TabItem => ({ tab, index })), (item: TabItem) => {
        Button() {
          Column() {
            Text(item.tab)
              .font({ 
                size: this.selectedTabIndex === item.index ? AppTokens.TypographyTokens.headline.size : AppTokens.TypographyTokens.body.size, 
                weight: this.selectedTabIndex === item.index ? AppTokens.TypographyTokens.headline.weight : AppTokens.TypographyTokens.body.weight 
              })
              .fontColor(this.selectedTabIndex === item.index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            
            if (this.selectedTabIndex === item.index) {
              Divider()
                .color(AppTokens.Colors.primary)
                .width('100%')
                .strokeWidth(2)
            } else {
              Divider()
                .color(Color.Transparent)
                .width('100%')
                .strokeWidth(2)
            }
          }
        }
        .onClick(() => {
          this.selectedTabIndex = item.index;
        })
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
      })
    }
    .animation({ duration: 200, curve: Curve.EaseInOut })
  }
}

@Component
export struct CourseList {
  title: string = '';
  count: number = 0;

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        Text(this.title)
          .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
          .fontColor(AppTokens.Colors.secondary)
          .textAlign(TextAlign.Start)
        
        ForEach(Array.from({ length: this.count }, (_, i: number): number => i), (index: number) => {
          CourseCard({ courseNumber: index + 1 })
        })
      }
      .width('100%')
    }
    .scrollBar(BarState.Off)
  }
}

@Entry
@Component
struct RootScreen {
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  @State selectedTabIndex: number = 0;
  private tabController: TabsController = new TabsController();

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.md }) {
        Text('Course Catalog')
          .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
          .fontColor(AppTokens.Colors.primary)
          .textAlign(TextAlign.Start)
          .width('100%')

        CustomTabRow({ tabs: this.tabs, selectedTabIndex: $selectedTabIndex })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)

        Tabs({ barPosition: BarPosition.Start, controller: this.tabController }) {
          TabContent() {
            CourseList({ title: 'All Courses', count: 6 })
          }
          .tabBar("")
          
          TabContent() {
            CourseList({ title: 'Enrolled', count: 3 })
          }
          .tabBar("")
          
          TabContent() {
            CourseList({ title: 'Completed', count: 4 })
          }
          .tabBar("")
        }
        .barMode(BarMode.Fixed)
        .onChange((index: number) => {
          this.selectedTabIndex = index;
        })
        .layoutWeight(1)
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}