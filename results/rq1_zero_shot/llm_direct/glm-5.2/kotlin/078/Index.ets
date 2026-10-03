import { 
  Length, 
  ResourceStr, 
  ImageSource 
} from '@ohos.arkui.UIContext';

// Define the Course class
class Course {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;

  constructor(title: string, subtitle: string, rating: string, bgColor: string, accentColor: string) {
    this.title = title;
    this.subtitle = subtitle;
    this.rating = rating;
    this.bgColor = bgColor;
    this.accentColor = accentColor;
  }
}

@Entry
@Component
struct CourseDashboardScreen {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];
  
  private courses: Course[] = [
    new Course('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1565C0'),
    new Course('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B'),
    new Course('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32')
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Scrollable Content
      Scroll() {
        Column() {
          // Header Section
          Row() {
            Column() {
              Text('Hello, Sophie')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
              Text('Let\'s start learning!')
                .fontSize(16)
                .fontColor('#888888')
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)

            Row() {
              Image($r('sys.symbol.bell'))
                .width(24).height(24).fillColor('#1C1B1F')
              
              // Profile Icon Box
              Stack() {
                Image($r('sys.symbol.face_smiling'))
                  .width(24).height(24).fillColor('#4E31AA')
              }
              .width(48).height(48)
              .borderRadius(24)
              .backgroundColor('#334E31AA')
              .margin({ left: 8 })
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding(24)

          // Search Bar Section
          Row() {
            Image($r('sys.symbol.magnifyingglass'))
              .width(20).height(20).fillColor('#888888')
            Text('Search for course...')
              .fontColor('#CCCCCC')
              .margin({ left: 16 })
              .layoutWeight(1)
            Image($r('sys.symbol.gearshape'))
              .width(20).height(20).fillColor('#4E31AA')
          }
          .width('90%')
          .height(56)
          .borderRadius(16)
          .backgroundColor('#FFFFFF')
          .padding({ left: 16, right: 16 })
          .alignItems(VerticalAlign.Center)

          // Ongoing Course Section
          Column() {
            Text('Ongoing Course')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1C1B1F')
            
            Row() {
              Column() {
                Text('3D Modeling')
                  .fontSize(14)
                  .fontColor('#B3FFFFFF')
                Text('Blender Basic')
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .margin({ top: 8 })
                
                Row() {
                  Text('75%')
                    .fontSize(12)
                    .fontColor('#FFFFFF')
                  // Progress Bar
                  Stack({ alignContent: Alignment.Start }) {
                    // Track
                    Column().width('100%').height(6).borderRadius(3).backgroundColor('#33FFFFFF')
                    // Progress
                    Column().width('75%').height(6).borderRadius(3).backgroundColor('#FFA726')
                  }
                  .width('70%')
                  .height(6)
                  .margin({ left: 8 })
                }
                .alignItems(VerticalAlign.Center)
                .margin({ top: 16 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              // Play Button
              Stack() {
                Image($r('sys.symbol.play_fill'))
                  .width(32).height(32).fillColor('#4E31AA')
              }
              .width(60).height(60)
              .borderRadius(30)
              .backgroundColor('#FFFFFF')
              .margin({ left: 16 })
            }
            .width('100%')
            .height(140)
            .padding(20)
            .borderRadius(24)
            .backgroundColor('#4E31AA')
            .alignItems(VerticalAlign.Center)
            .margin({ top: 16 })
          }
          .width('100%')
          .padding(24)
          .alignItems(HorizontalAlign.Start)

          // Categories Section
          Scroll() {
            Row() {
              ForEach(this.categories, (category: string) => {
                Text(category)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(category === 'Design' ? '#FFFFFF' : '#888888')
                  .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                  .borderRadius(12)
                  .backgroundColor(category === 'Design' ? '#FF7043' : '#FFFFFF')
                  .margin({ right: 12 })
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .padding({ left: 24, right: 24 })

          // Recommended Section
          Column() {
            Row() {
              Text('Recommended')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
              Text('See all')
                .fontColor('#888888')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            ForEach(this.courses, (course: Course) => {
              // Course Card
              Row() {
                // Icon Box
                Stack() {
                  Image(course.title.includes('Mobile') ? $r('sys.symbol.checkmark_circle_fill') : $r('sys.symbol.star_fill'))
                    .width(32).height(32).fillColor(course.accentColor)
                }
                .width(100).height('100%')
                .backgroundColor(course.bgColor)
                .justifyContent(FlexAlign.Center)

                // Text Content
                Column() {
                  Text(course.subtitle)
                    .fontSize(12)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#4E31AA')
                  Text(course.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#1C1B1F')
                    .margin({ top: 2 })
                  Row() {
                    Image($r('sys.symbol.star_fill'))
                      .width(16).height(16).fillColor('#FFB300')
                    Text(course.rating)
                      .fontSize(12)
                      .fontColor('#888888')
                      .margin({ left: 4 })
                  }
                  .alignItems(VerticalAlign.Center)
                  .margin({ top: 4 })
                }
                .layoutWeight(1)
                .padding(16)
                .alignItems(HorizontalAlign.Start)

                // Favorite Icon
                Image($r('sys.symbol.heart'))
                  .width(24).height(24).fillColor('#EEEEEE')
                  .margin({ right: 16 })
              }
              .width('100%')
              .height(100)
              .borderRadius(20)
              .backgroundColor('#FFFFFF')
              .alignItems(VerticalAlign.Center)
              .margin({ top: 16 })
            })
          }
          .width('100%')
          .padding(24)
          .alignItems(HorizontalAlign.Start)
        }
      }
      .scrollBar(BarState.Off)
      .padding({ bottom: 80 })

      // Bottom Navigation Bar
      Row() {
        Image($r('sys.symbol.house_fill'))
          .width(24).height(24).fillColor('#FFFFFF')
        Image($r('sys.symbol.magnifyingglass'))
          .width(24).height(24).fillColor('#888888')
        Image($r('sys.symbol.heart'))
          .width(24).height(24).fillColor('#888888')
        Image($r('sys.symbol.face_smiling'))
          .width(24).height(24).fillColor('#888888')
      }
      .width('90%')
      .padding({ top: 16, bottom: 16 })
      .borderRadius(32)
      .backgroundColor('#1E1E1E')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}