// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#111111',
    secondary: '#444444',
    background: '#F5F5F5',
    surface: '#FFFFFF',
    outline: '#CCCCCC',
    onPrimary: '#FFFFFF',
    onSurface: '#111111'
  }

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.SemiBold },
    body: { size: 14, weight: FontWeight.Normal }
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16
  }

  static readonly ElevationMapping = {
    level1: { blurRadius: 4, yOffset: 2, opacity: 0.1 }
  }
}

// CourseCard.ets
import { AppTokens } from './AppTokens';

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

// CustomTabRow.ets
import { AppTokens } from './AppTokens';

@Component
export struct CustomTabRow {
  tabs: string[];
  @Link selectedTabIndex: number;

  build() {
    Row() {
      ForEach(this.tabs.map((tab, index) => ({ tab, index })), (item) => {
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

// CourseList.ets
import { AppTokens } from './AppTokens';
import { CourseCard } from './CourseCard';

@Component
export struct CourseList {
  title: string;
  count: number;

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        Text(this.title)
          .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
          .fontColor(AppTokens.Colors.secondary)
          .textAlign(TextAlign.Start)
        
        ForEach(Array.from({ length: this.count }, (_, i) => i), (index) => {
          CourseCard({ courseNumber: index + 1 })
        })
      }
      .width('100%')
    }
    .scrollBar(BarState.Off)
  }
}

// RootScreen.ets
import { AppTokens } from './AppTokens';
import { CustomTabRow } from './CustomTabRow';
import { CourseList } from './CourseList';

@Entry
@Component
struct RootScreen {
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  @State selectedTabIndex: number = 0;

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

        Tabs({ barPosition: BarPosition.Start, controller: this.getTabController() }) {
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

  getTabController(): TabsController {
    return new TabsController();
  }
}