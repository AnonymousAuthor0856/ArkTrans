import { router } from '@kit.ArkRouter'
import { hilog } from '@kit.PerformanceAnalysisKit'

const TAG: string = '[CourseDashboard]'
const DOMAIN: number = 0x0000

export interface CourseData {
  title: string
  subtitle: string
  rating: string
  bgColor: ResourceColor
  accentColor: ResourceColor
}

@Entry
@Component
struct CourseDashboardScreen {
  @State categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']
  @State selectedCategoryIndex: number = 1 // Design is index 1
  @State courses: CourseData[] = [
    {
      title: 'Mobile Dev',
      subtitle: 'Android Compose',
      rating: '4.9',
      bgColor: '#E3F2FD',
      accentColor: '#1565C0'
    },
    {
      title: 'Photography',
      subtitle: 'Master Lighting',
      rating: '4.7',
      bgColor: '#FCE4EC',
      accentColor: '#C2185B'
    },
    {
      title: 'Finance',
      subtitle: 'Crypto Trading',
      rating: '4.5',
      bgColor: '#E8F5E9',
      accentColor: '#2E7D32'
    }
  ]

  build() {
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {
        Scroll() {
          Column() {
            HeaderSection()
            SearchBarSection()
            OngoingCourseSection()
            CategoriesSection({ categories: this.categories, selectedIndex: this.selectedCategoryIndex })
            RecommendedSection({ courses: this.courses })
            // Bottom padding to account for the floating nav bar
            Blank().height(100)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .edgeEffect(EdgeEffect.Spring)

        BottomNavigationBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text("Hello, Sophie")
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
          .fontColor('#1C1B1F')
        
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#757575')
          .margin({ top: 4 })
      }

      Row() {
        Button() {
          Image($r('app.media.ic_notifications')) // Placeholder for icon
            .width(24)
            .height(24)
            .fillColor('#1C1B1F')
        }
        .type(ButtonType.Circle)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .margin({ right: 8 })

        Button() {
          Image($r('app.media.ic_face')) // Placeholder for icon
            .width(24)
            .height(24)
            .fillColor('#4E31AA')
        }
        .type(ButtonType.Circle)
        .backgroundColor('#4E31AA1A') // Primary with alpha
        .borderWidth(0)
      }
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SearchBarSection {
  build() {
    Row() {
      Image($r('app.media.ic_search')) // Placeholder
        .width(24)
        .height(24)
        .fillColor('#757575')
      
      Text("Search for course...")
        .fontColor('#BDBDBD')
        .fontSize(16)
        .margin({ left: 16 })
      
      Blank()
      
      Image($r('app.media.ic_settings')) // Placeholder
        .width(24)
        .height(24)
        .fillColor('#4E31AA')
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .padding({ left: 16, right: 16 })
    .margin({ left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct OngoingCourseSection {
  build() {
    Column() {
      Text("Ongoing Course")
        .fontWeight(FontWeight.Bold)
        .fontSize(20)
        .fontColor('#1C1B1F')
      
      Row() {
        Column() {
          .layoutWeight(1)
          
          Text("3D Modeling")
            .fontColor('#FFFFFFB3') // White with alpha
            .fontSize(14)
          
          Text("Blender Basic")
            .fontColor(Color.White)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 8 })
            
          Row() {
            .alignItems(VerticalAlign.Center)
            .margin({ top: 16 })
            
            Text("75%")
              .fontColor(Color.White)
              .fontSize(12)
            
            Progress({ value: 75, total: 100, type: ProgressType.Linear })
              .width('100%')
              .height(6)
              .margin({ left: 8 })
              .backgroundColor('#FFFFFF33') // Track color
              .color('#FFA726') // Progress color
          }
        }

        Button() {
          Image($r('app.media.ic_play_arrow')) // Placeholder
            .width(32)
            .height(32)
            .fillColor('#4E31AA')
        }
        .type(ButtonType.Circle)
        .backgroundColor(Color.White)
        .borderWidth(0)
        .margin({ left: 16 })
      }
      .width('100%')
      .height(140)
      .backgroundColor('#4E31AA')
      .borderRadius(24)
      .padding(20)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(24)
  }
}

@Component
struct CategoriesSection {
  @Prop categories: string[]
  @Prop selectedIndex: number

  build() {
    Column() {
      List({ space: 12 }) {
        ForEach(this.categories, (category: string, index: number) => {
          ListItem() {
            Text(category)
              .fontColor(index === this.selectedIndex ? Color.White : '#757575')
              .fontWeight(FontWeight.Medium)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .backgroundColor(index === this.selectedIndex ? '#FF7043' : Color.White)
              .borderRadius(12)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollable(ScrollDirection.Horizontal)
      .edgeEffect(EdgeEffect.None)
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .margin({ top: 24 })
  }
}

@Component
struct RecommendedSection {
  @Prop courses: CourseData[]

  build() {
    Column() {
      Row() {
        Text("Recommended")
          .fontWeight(FontWeight.Bold)
          .fontSize(20)
          .fontColor('#1C1B1F')
        
        Blank()
        
        Text("See all")
          .fontColor('#757575')
          .fontSize(14)
      }
      .width('100%')
      .margin({ top: 24 })

      Column() {
        ForEach(this.courses, (course: CourseData) => {
          CourseCard({ course: course })
            .margin({ bottom: 16 })
        })
      }
    }
    .width('100%')
    .padding(24)
  }
}

@Component
struct CourseCard {
  @Prop course: CourseData

  build() {
    Row() {
      Column() {
        .width(100)
        .height('100%')
        .backgroundColor(this.course.bgColor as ResourceColor)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        
        // Using a simple circle as placeholder for icon based on logic
        Circle()
          .width(32)
          .height(32)
          .fill(this.course.accentColor as ResourceColor)
      }

      Column() {
        .layoutWeight(1)
        .margin({ left: 16 })
        
        Text(this.course.subtitle)
          .fontColor('#4E31AA')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
        
        Text(this.course.title)
          .fontWeight(FontWeight.Bold)
          .fontSize(18)
          .fontColor('#1C1B1F')
          .margin({ top: 4 })
          
        Row() {
          .alignItems(VerticalAlign.Center)
          .margin({ top: 4 })
          
          StarIcon()
          
          Text(this.course.rating)
            .fontColor('#757575')
            .fontSize(12)
            .margin({ left: 4 })
        }
      }

      Button() {
        HeartIcon()
      }
      .type(ButtonType.Circle)
      .backgroundColor(Color.Transparent)
      .borderWidth(0)
    }
    .width('100%')
    .height(100)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}

// Helper components for icons since we don't have the exact vector assets
@Component
struct StarIcon {
  build() {
    SymbolGlyph($r('sys.symbol.star'))
      .fontSize(16)
      .fontColor('#FFB300')
  }
}

@Component
struct HeartIcon {
  build() {
    SymbolGlyph($r('sys.symbol.heart'))
      .fontSize(24)
      .fontColor('#EEEEEE')
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      NavItem({ iconRes: $r('sys.symbol.home'), isActive: true })
      NavItem({ iconRes: $r('sys.symbol.search'), isActive: false })
      NavItem({ iconRes: $r('sys.symbol.heart'), isActive: false })
      NavItem({ iconRes: $r('sys.symbol.person'), isActive: false })
    }
    .width('100%')
    .height(70)
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .margin({ left: 24, right: 24, bottom: 24 })
    .shadow({ radius: 8, color: '#00000033', offsetY: 4 })
  }
}

@Component
struct NavItem {
  @Prop iconRes: Resource
  @Prop isActive: boolean

  build() {
    SymbolGlyph(this.iconRes)
      .fontSize(24)
      .fontColor(this.isActive ? Color.White : '#757575')
  }
}