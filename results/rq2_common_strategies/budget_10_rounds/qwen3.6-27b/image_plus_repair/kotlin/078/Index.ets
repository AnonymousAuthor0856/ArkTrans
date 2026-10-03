import { router } from '@kit.ArkUI';

interface CourseData {
  title: string;
  subtitle: string;
  rating: string;
  color: string;
  accent: string;
}

@Entry
@Component
struct CourseDashboardScreen {
  @State isDarkMode: boolean = false;
  private scrollController: Scroller = new Scroller();

  build() {
    Column() {
      // Main Content Area
      Scroll(this.scrollController) {
        Column({ space: 24 }) {
          HeaderSection()
          SearchBarSection()
          OngoingCourseSection()
          CategoriesSection()
          RecommendedSection()
          // Bottom padding to ensure content isn't hidden behind the nav bar
          Blank().height(100)
        }
        .padding({ left: 24, right: 24, top: 56 })
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F7')
      .scrollBar(BarState.Off)

      // Floating Bottom Navigation Bar
      BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}

// --- Components ---

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text("Hello, Sophie")
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        
        Text("Let's start learning!")
          .fontSize(18)
          .fontColor('#9E9E9E')
          .margin({ top: 4 })
      }

      Row({ space: 12 }) {
        Button()
          .type(ButtonType.Circle)
          .width(48)
          .height(48)
          .backgroundColor('transparent')
          .borderWidth(0)
          .onClick(() => { /* Notification logic */ })
          .child(
            Image($r('app.media.ic_notification')) // Placeholder for bell icon using standard image resource or symbol if available
              .width(24)
              .height(24)
              .fillColor('#1C1B1F')
          )

        Button()
          .type(ButtonType.Circle)
          .width(48)
          .height(48)
          .backgroundColor('#4E31AA')
          .opacity(0.2)
          .onClick(() => { /* Profile logic */ })
          .child(
             // Simple circle avatar placeholder
             Circle()
               .width(24)
               .height(24)
               .fill('#4E31AA')
          )
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SearchBarSection {
  build() {
    Row() {
      Image($r('app.media.search_icon'))
        .width(20)
        .height(20)
        .fillColor('#9E9E9E')
      
      Text("Search for course...")
        .fontSize(16)
        .fontColor('#CCCCCC')
        .margin({ left: 12 })
        .layoutWeight(1)

      Image($r('app.media.settings_icon'))
        .width(24)
        .height(24)
        .fillColor('#4E31AA')
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct OngoingCourseSection {
  build() {
    Column() {
      Text("Ongoing Course")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
        .margin({ bottom: 16 })

      Row() {
        Column() {
          Text("3D Modeling")
            .fontSize(14)
            .fontColor('#FFFFFF')
            .opacity(0.7)
          
          Text("Blender Basic")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ top: 8 })

          Row() {
            Text("75%")
              .fontSize(12)
              .fontColor('#FFFFFF')
            
            Progress({ value: 75, total: 100, type: ProgressType.Linear })
              .width('100%')
              .height(6)
              .margin({ left: 8 })
              .color('#FFA726')
              .trackColor('#FFFFFF')
              .trackOpacity(0.2)
              .borderRadius(4)
          }
          .width('100%')
          .margin({ top: 16 })
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)

        Button()
          .type(ButtonType.Circle)
          .width(60)
          .height(60)
          .backgroundColor('#FFFFFF')
          .borderWidth(0)
          .onClick(() => { /* Play logic */ })
          .child(
            // Triangle play icon simulation
            Path()
              .commands('M10 16.5 L16 12 L10 7.5 Z')
              .fill('#4E31AA')
              .width(24)
              .height(24)
          )
      }
      .width('100%')
      .height(140)
      .padding(20)
      .backgroundColor('#4E31AA')
      .borderRadius(24)
      .alignItems(VerticalAlign.Center)
    }
  }
}

@Component
struct CategoriesSection {
  private categories: string[] = ["Coding", "Design", "Business", "Photo", "Music"];

  build() {
    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
      ForEach(this.categories, (category: string) => {
        Button(category)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ right: 12, bottom: 12 })
          .borderRadius(12)
          .height(48)
          .padding({ left: 24, right: 24 })
          .backgroundColor(category === "Design" ? '#FF7043' : Color.White)
          .fontColor(category === "Design" ? Color.White : '#9E9E9E')
          .borderWidth(0)
      })
    }
  }
}

@Component
struct RecommendedSection {
  private courses: CourseData[] = [
    { title: "Mobile Dev", subtitle: "Android Compose", rating: "4.9", color: "#E3F2FD", accent: "#1565C0" },
    { title: "Photography", subtitle: "Master Lighting", rating: "4.7", color: "#FCE4EC", accent: "#C2185B" },
    { title: "Finance", subtitle: "Crypto Trading", rating: "4.5", color: "#E8F5E9", accent: "#2E7D32" }
  ];

  build() {
    Column() {
      Row() {
        Text("Recommended")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        
        Text("See all")
          .fontSize(16)
          .fontColor('#9E9E9E')
          .margin({ left: 20 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 16 })

      Column({ space: 16 }) {
        ForEach(this.courses, (course: CourseData) => {
          CourseCard({ course: course })
        })
      }
    }
  }
}

@Component
struct CourseCard {
  @Prop course: CourseData;

  build() {
    Row() {
      // Icon Box
      Row() {
        // Placeholder for specific icons based on category
        if (this.course.title.includes("Mobile")) {
           Image($r('app.media.check_circle_icon'))
             .fillColor(this.course.accent)
             .width(32)
             .height(32)
        } else {
           Image($r('app.media.star_icon'))
             .fillColor(this.course.accent)
             .width(32)
             .height(32)
        }
      }
      .width(100)
      .height('100%')
      .backgroundColor(this.course.color)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Text Info
      Column() {
        Text(this.course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')
        
        Text(this.course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ top: 4 })

        Row() {
          Image($r('app.media.star_icon'))
            .width(16)
            .height(16)
            .fillColor('#FFB300')
          
          Text(this.course.rating)
            .fontSize(12)
            .fontColor('#9E9E9E')
            .margin({ left: 4 })
        }
        .margin({ top: 4 })
      }
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })

      // Favorite Icon
      Image($r('app.media.heart_icon'))
        .width(24)
        .height(24)
        .fillColor('#EEEEEE')
    }
    .width('100%')
    .height(100)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      // Home
      Column() {
        Image($r('app.media.home_icon'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      // Search
      Column() {
        Image($r('app.media.search_icon'))
          .width(24)
          .height(24)
          .fillColor('#9E9E9E')
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      // Heart
      Column() {
        Image($r('app.media.heart_icon'))
          .width(24)
          .height(24)
          .fillColor('#9E9E9E')
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      // User
      Column() {
        Image($r('app.media.user_icon'))
          .width(24)
          .height(24)
          .fillColor('#9E9E9E')
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(70)
    .padding({ left: 24, right: 24 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({ radius: 10, color: '#00000033', offsetY: 4 })
    .position({ bottom: 24, left: 24, right: 24 })
  }
}