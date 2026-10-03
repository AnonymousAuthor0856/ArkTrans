// MARK: - Models
interface Course {
  id: number;
  title: string;
  subtitle: string;
  rating: string;
  bgColor: ResourceColor;
  accentColor: ResourceColor;
  iconName: string;
}

// MARK: - Theme
class AppTheme {
  static primary: string = '#4E31AA';
  static secondary: string = '#3A1C71';
  static background: string = '#F5F5F7';
  static surface: string = '#FFFFFF';
  static onBackground: string = '#1C1B1F';
  static progressColor: string = '#FFA726';
  static selectedCategoryColor: string = '#FF7043';
  static grayText: string = '#999999';
  static lightGrayBg: string = '#EEEEEE';
  static amber: string = '#FFB300';
}

@Entry
@Component
struct CourseApp {
  build() {
    Column() {
      CourseDashboardScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.background)
  }
}

@Component
struct CourseDashboardScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            HeaderSection()
            SearchBarSection()
            OngoingCourseSection()
            CategoriesSection()
            RecommendedSection()
            // Bottom padding for floating nav bar
            Blank().height(100)
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      
      BottomNavigationBar()
        .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 4 }) {
        Text("Hello, Sophie")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
        
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#999999')
      }
      
      Blank()
      
      Row({ space: 8 }) {
        Button() {
          Image($r('app.media.ic_bell')) // Placeholder for bell icon
            .width(24)
            .height(24)
            .fillColor(AppTheme.onBackground)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        
        Stack() {
          Circle()
            .fill(AppTheme.primary)
            .opacity(0.2)
            .width(48)
            .height(48)
          
          Image($r('app.media.ic_face')) // Placeholder for face icon
            .width(24)
            .height(24)
            .fillColor(AppTheme.primary)
        }
      }
    }
    .padding(24)
    .width('100%')
  }
}

@Component
struct SearchBarSection {
  build() {
    Row() {
      Image($r('app.media.ic_search')) // Placeholder for search icon
        .width(20)
        .height(20)
        .fillColor('#999999')
      
      Text("Search for course...")
        .fontSize(14)
        .fontColor('#CCCCCC')
        .layoutWeight(1)
        .margin({ left: 16 })
      
      Image($r('app.media.ic_filter')) // Placeholder for filter icon
        .width(20)
        .height(20)
        .fillColor(AppTheme.primary)
    }
    .padding({ left: 16, right: 16 })
    .height(56)
    .backgroundColor(AppTheme.surface)
    .borderRadius(16)
    .margin({ left: 24, right: 24 })
  }
}

@Component
struct OngoingCourseSection {
  build() {
    Column({ space: 16 }) {
      Text("Ongoing Course")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTheme.onBackground)
        .alignSelf(ItemAlign.Start)
      
      Stack() {
        // Background Card
        Rect()
          .fill(AppTheme.primary)
          .borderRadius(24)
          .height(140)
          .width('100%')
        
        Row({ space: 16 }) {
          Column({ space: 0 }) {
            Text("3D Modeling")
              .fontSize(14)
              .fontColor('#B3FFFFFF') // White with opacity
            
            Blank().height(8)
            
            Text("Blender Basic")
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            
            Blank().height(16)
            
            Row({ space: 8 }) {
              Text("75%")
                .fontSize(12)
                .fontColor(Color.White)
              
              Progress({ value: 75, total: 100, type: ProgressType.Linear })
                .width('100%')
                .height(6)
                .backgroundColor('#33FFFFFF')
                .color(AppTheme.progressColor)
                .layoutWeight(1)
            }
          }
          
          Blank()
          
          Stack() {
            Circle()
              .fill(Color.White)
              .width(60)
              .height(60)
            
            Image($r('app.media.ic_play')) // Placeholder for play icon
              .width(32)
              .height(32)
              .fillColor(AppTheme.primary)
              .offset({ x: 2, y: 0 })
          }
        }
        .padding(20)
      }
    }
    .padding(24)
    .width('100%')
  }
}

@Component
struct CategoriesSection {
  private categories: string[] = ["Coding", "Design", "Business", "Photo", "Music"];
  
  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          let isSelected = category === "Design";
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(isSelected ? Color.White : '#999999')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(isSelected ? AppTheme.selectedCategoryColor : AppTheme.surface)
            .borderRadius(12)
        })
      }
      .padding({ left: 12, right: 12 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct RecommendedSection {
  private courses: Course[] = [
    { 
      id: 1, 
      title: "Mobile Dev", 
      subtitle: "Android Compose", 
      rating: "4.9", 
      bgColor: '#E3F2FD', 
      accentColor: '#1565C0', 
      iconName: 'ic_check' 
    },
    { 
      id: 2, 
      title: "Photography", 
      subtitle: "Master Lighting", 
      rating: "4.7", 
      bgColor: '#FCE4EC', 
      accentColor: '#C2185B', 
      iconName: 'ic_star' 
    },
    { 
      id: 3, 
      title: "Finance", 
      subtitle: "Crypto Trading", 
      rating: "4.5", 
      bgColor: '#E8F5E9', 
      accentColor: '#2E7D32', 
      iconName: 'ic_star' 
    }
  ];

  build() {
    Column({ space: 16 }) {
      Row() {
        Text("Recommended")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
        
        Blank()
        
        Text("See all")
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      
      Column({ space: 16 }) {
        ForEach(this.courses, (course: Course) => {
          CourseCard({ course: course })
        })
      }
    }
    .padding(24)
    .width('100%')
  }
}

@Component
struct CourseCard {
  @Prop course: Course;

  build() {
    Stack() {
      Rect()
        .fill(Color.White)
        .borderRadius(20)
        .height(100)
        .width('100%')
      
      Row() {
        // Left Icon Box
        Stack() {
          Rect()
            .fill(this.course.bgColor)
            .width(100)
            .height(100)
          
          Image($r(`app.media.${this.course.iconName}`)) // Dynamic resource loading requires pre-defined resources in real app
            .width(32)
            .height(32)
            .fillColor(this.course.accentColor)
        }
        .clip(true)
        .borderRadius(50)
        
        // Content
        Column({ space: 4 }) {
          Text(this.course.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.primary)
          
          Text(this.course.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.onBackground)
          
          Row({ space: 4 }) {
            Image($r('app.media.ic_star_filled'))
              .width(12)
              .height(12)
              .fillColor(AppTheme.amber)
            
            Text(this.course.rating)
              .fontSize(12)
              .fontColor('#999999')
          }
        }
        .padding(16)
        .layoutWeight(1)
        
        // Favorite Icon
        Button() {
          Image($r('app.media.ic_heart'))
            .width(20)
            .height(20)
            .fillColor('#EEEEEE')
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .margin({ right: 16 })
      }
    }
    .width('100%')
    .height(100)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row({ space: 40 }) {
      Image($r('app.media.ic_home_filled'))
        .width(24)
        .height(24)
        .fillColor(Color.White)
      
      Image($r('app.media.ic_search'))
        .width(24)
        .height(24)
        .fillColor('#999999')
      
      Image($r('app.media.ic_heart'))
        .width(24)
        .height(24)
        .fillColor('#999999')
      
      Image($r('app.media.ic_person'))
        .width(24)
        .height(24)
        .fillColor('#999999')
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
    .margin({ left: 24, right: 24 })
  }
}