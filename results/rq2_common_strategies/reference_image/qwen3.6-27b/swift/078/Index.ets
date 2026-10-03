// entry/src/main/ets/view/CourseApp.ets

@Entry
@Component
struct CourseApp {
  @State private isDesignSelected: boolean = true;

  build() {
    Column() {
      // Main Scrollable Content
      Scroll() {
        Column() {
          HeaderSection()
          SearchBarSection()
          OngoingCourseSection()
          CategoriesSection({ onSelect: (isSelected: boolean) => this.isDesignSelected = isSelected })
          RecommendedSection()
          
          // Bottom padding to ensure content isn't hidden behind the floating nav bar
          Blank().height(100)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F7')
      
      // Floating Navigation Bar
      BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
    .statusBarMode(StatusBarMode.Custom)
    .statusBarColor('#F5F5F7')
  }
}

// MARK: - Models & Data

interface CourseData {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: ResourceColor;
  accentColor: ResourceColor;
  iconName: string;
}

const COURSES_DATA: CourseData[] = [
  {
    title: "Mobile Dev",
    subtitle: "Android Compose",
    rating: "4.9",
    bgColor: '#E3F2FD', // Light Blue
    accentColor: '#1565C0', // Dark Blue
    iconName: "checkmark.circle.fill"
  },
  {
    title: "Photography",
    subtitle: "Master Lighting",
    rating: "4.7",
    bgColor: '#FCE4EC', // Light Pink
    accentColor: '#C2185B', // Dark Pink
    iconName: "star.fill"
  },
  {
    title: "Finance",
    subtitle: "Crypto Trading",
    rating: "4.5",
    bgColor: '#E8F5E9', // Light Green
    accentColor: '#2E7D32', // Dark Green
    iconName: "star.fill"
  }
];

// MARK: - Components

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ align: HorizontalAlign.Start }) {
        Text("Hello, Sophie")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#9E9E9E')
          .margin({ top: 4 })
      }
      
      Blank()
      
      Row() {
        // Notification Icon
        Image($r('app.media.ic_bell')) // Placeholder for bell icon
          .width(24)
          .height(24)
          .fillColor('#1C1B1F')
          .margin({ right: 8 })
        
        // Profile Avatar
        Circle()
          .width(48)
          .height(48)
          .backgroundColor('#D1C4E9') // Light Purple background
          .borderRadius(24)
          .child(
            Image($r('app.media.ic_face')) // Placeholder for face icon
              .width(24)
              .height(24)
              .fillColor('#4E31AA')
          )
      }
    }
    .width('100%')
    .padding(24)
  }
}

@Component
struct SearchBarSection {
  build() {
    Row() {
      Image($r('app.media.ic_search')) // Placeholder for search icon
        .width(20)
        .height(20)
        .fillColor('#9E9E9E')
      
      Text("Search for course...")
        .fontSize(16)
        .fontColor('#BDBDBD')
        .margin({ left: 16 })
      
      Blank()
      
      Image($r('app.media.ic_filter')) // Placeholder for filter icon
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
  }
}

@Component
struct OngoingCourseSection {
  build() {
    Column({ align: HorizontalAlign.Start }) {
      Text("Ongoing Course")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
        .margin({ bottom: 16 })
      
      // Card Container
      Row() {
        // Left Content
        Column({ align: HorizontalAlign.Start }) {
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
              .width('60%')
              .height(6)
              .color('#FFA726') // Orange progress
              .trackColor('#FFFFFF') // White track with opacity handled by container or separate rect
              .margin({ left: 8 })
          }
          .margin({ top: 16 })
        }
        
        Blank()
        
        // Play Button
        Circle()
          .width(60)
          .height(60)
          .backgroundColor(Color.White)
          .child(
            Image($r('app.media.ic_play')) // Placeholder for play icon
              .width(32)
              .height(32)
              .fillColor('#4E31AA')
              .margin({ left: 2 }) // Visual center adjustment
          )
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#4E31AA') // Primary Purple
      .borderRadius(24)
    }
    .padding(24)
  }
}

@Component
struct CategoriesSection {
  @Link isSelected: boolean;
  
  categories: string[] = ["Coding", "Design", "Business", "Photo", "Music"];
  
  build() {
    Scroll() {
      Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.Start }) {
        ForEach(this.categories, (category: string) => {
          CategoryChip({ 
            label: category, 
            isSelected: category === "Design" ? this.isSelected : false 
          })
        }, (item: string) => item)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct CategoryChip {
  @Prop label: string;
  @Prop isSelected: boolean;

  build() {
    Text(this.label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? Color.White : '#9E9E9E')
      .backgroundColor(this.isSelected ? '#FF7043' : Color.White) // Orange if selected, else white
      .borderRadius(12)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .margin({ right: 12 })
  }
}

@Component
struct RecommendedSection {
  build() {
    Column({ align: HorizontalAlign.Start }) {
      Row() {
        Text("Recommended")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        
        Blank()
        
        Text("See all")
          .fontSize(16)
          .fontColor('#9E9E9E')
      }
      .width('100%')
      .margin({ bottom: 16 })
      
      ForEach(COURSES_DATA, (course: CourseData) => {
        CourseCard(course: course)
      }, (item: CourseData) => item.title)
    }
    .padding(24)
  }
}

@Component
struct CourseCard {
  @Prop course: CourseData;

  build() {
    Row() {
      // Left Icon Box
      Row() {
        Image($r('app.media.ic_check')) // Generic placeholder, logic below handles color
          .width(32)
          .height(32)
          .fillColor(this.course.accentColor)
      }
      .width(100)
      .height(100)
      .backgroundColor(this.course.bgColor)
      .borderRadius({ topLeft: 20, bottomLeft: 20 })
      
      // Content
      Column({ align: HorizontalAlign.Start }) {
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
          Image($r('app.media.ic_star'))
            .width(12)
            .height(12)
            .fillColor('#FFCA28') // Amber
            
          Text(this.course.rating)
            .fontSize(12)
            .fontColor('#9E9E9E')
            .margin({ left: 4 })
        }
        .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
      .layoutWeight(1)
      .padding(16)
      
      // Favorite Icon
      Image($r('app.media.ic_heart'))
        .width(24)
        .height(24)
        .fillColor('#EEEEEE')
        .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .margin({ bottom: 16 })
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      NavItem({ icon: $r('app.media.ic_home'), isActive: true })
      NavItem({ icon: $r('app.media.ic_search'), isActive: false })
      NavItem({ icon: $r('app.media.ic_heart'), isActive: false })
      NavItem({ icon: $r('app.media.ic_person'), isActive: false })
    }
    .width('100%')
    .height(64)
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.2)', offsetY: 4 })
    .padding({ left: 24, right: 24 })
    .margin({ bottom: 24 })
  }
}

@Component
struct NavItem {
  @Prop icon: Resource;
  @Prop isActive: boolean;

  build() {
    Image(this.icon)
      .width(24)
      .height(24)
      .fillColor(this.isActive ? Color.White : '#9E9E9E')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
  }
}