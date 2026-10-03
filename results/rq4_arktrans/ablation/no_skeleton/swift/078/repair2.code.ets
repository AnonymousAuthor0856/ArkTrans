import { ImageColorFilterMode } from '@kit.ArkGraphics'

@Entry
@Component
struct CourseApp {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // === Column (Scrollable Content) ===
      // props: { space: 0 }
      // modifier: { width: '100%' }
      // children: 1
      Column() {
        // === Scroll ===
        // props: { scroller: Scroller.new(), edgeEffect: EdgeEffect.Spring }
        // modifier: { width: '100%' }
        // children: 1
        Scroll() {
          // === Column ===
          // props: { space: 0 }
          // children: 5
          Column() {
            // === HeaderSection ===
            // children: 1
            HeaderSection()

            // === SearchBarSection ===
            // children: 1
            SearchBarSection()

            // === OngoingCourseSection ===
            // children: 1
            OngoingCourseSection()

            // === CategoriesSection ===
            // children: 1
            CategoriesSection()

            // === RecommendedSection ===
            // children: 1
            RecommendedSection()

            // === Blank ===
            // modifier: { height: 100 }
            Blank().height(100)
          }
        }
      }.width('100%')

      // === BottomNavigationBar ===
      // modifier: { margin: { bottom: 24, left: 24, right: 24 } }
      // children: 1
      BottomNavigationBar()
    }
    // modifier: { width: '100%', height: '100%', backgroundColor: '#F5F5F7' }
  }
}

// === Components ===

@Component
struct HeaderSection {
  build() {
    // === Row ===
    // props: { space: 8 }
    // modifier: { width: '100%', padding: 24 }
    // children: 3
    Row() {
      // === Column ===
      // props: { space: 4 }
      // modifier: { alignItems: ItemAlign.Start }
      // children: 2
      Column() {
        // === Text ===
        // props: { text: 'Hello, Sophie' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#1C1B1F' }
        Text('Hello, Sophie').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#1C1B1F')
        // === Text ===
        // props: { text: "Let's start learning!" }
        // modifier: { fontSize: 16, color: '#9E9E9E' }
        Text("Let's start learning!").fontSize(16).fontColor('#9E9E9E')
      }

      // === Blank ===
      Blank()

      // === Row ===
      // props: { space: 8 }
      // children: 2
      Row() {
        // === Image ===
        // modifier: { width: 24, height: 24, colorFilter: { sourceColor: '#1C1B1F', mode: ImageColorFilterMode.SRC_IN } }
        Image($r('app.media.startIcon')).width(24).height(24).colorFilter({ sourceColor: '#1C1B1F', mode: ImageColorFilterMode.SrcIn })
        
        // === Circle ===
        // modifier: { width: 48, height: 48, backgroundColor: '#4E31AA', opacity: 0.2 }
        // children: 1
        Circle()
          .width(48).height(48).backgroundColor('#4E31AA').opacity(0.2)
          
        // === Image ===
        // modifier: { width: 24, height: 24, colorFilter: { sourceColor: '#4E31AA', mode: ImageColorFilterMode.SRC_IN } }
        Image($r('app.media.startIcon')).width(24).height(24).colorFilter({ sourceColor: '#4E31AA', mode: ImageColorFilterMode.SrcIn })
      }
    }.width('100%').padding(24)
  }
}

@Component
struct SearchBarSection {
  build() {
    // === Row ===
    // props: { space: 16 }
    // modifier: { width: '100%', height: 56, padding: { left: 16, right: 16 }, backgroundColor: '#FFF', borderRadius: 16, margin: { left: 24, right: 24 } }
    // children: 3
    Row() {
      // === Image ===
      // modifier: { width: 24, height: 24, colorFilter: { sourceColor: '#9E9E9E', mode: ImageColorFilterMode.SRC_IN } }
      Image($r('app.media.startIcon')).width(24).height(24).colorFilter({ sourceColor: '#9E9E9E', mode: ImageColorFilterMode.SrcIn })
      
      // === Text ===
      // props: { text: 'Search for course...' }
      // modifier: { color: '#D1D1D6' }
      Text('Search for course...').fontColor('#D1D1D6')
      
      // === Blank ===
      Blank()
      
      // === Image ===
      // modifier: { width: 24, height: 24, colorFilter: { sourceColor: '#4E31AA', mode: ImageColorFilterMode.SRC_IN } }
      Image($r('app.media.startIcon')).width(24).height(24).colorFilter({ sourceColor: '#4E31AA', mode: ImageColorFilterMode.SrcIn })
    }.width('100%').height(56).padding({ left: 16, right: 16 }).backgroundColor('#FFF').borderRadius(16).margin({ left: 24, right: 24 })
  }
}

@Component
struct OngoingCourseSection {
  build() {
    // === Column ===
    // props: { space: 16 }
    // modifier: { width: '100%', padding: 24, alignItems: ItemAlign.Start }
    // children: 2
    Column() {
      // === Text ===
      // props: { text: 'Ongoing Course' }
      // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, color: '#1C1B1F' }
      Text('Ongoing Course').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#1C1B1F')

      // === Stack ===
      // props: { alignContent: Alignment.Center }
      // modifier: { width: '100%', height: 140, backgroundColor: '#4E31AA', borderRadius: 24 }
      // children: 1
      Stack() {
        // === Row ===
        // props: { space: 16 }
        // modifier: { width: '100%', padding: 20 }
        // children: 2
        Row() {
          // === Column ===
          // props: { space: 8 }
          // modifier: { layoutWeight: 1, alignItems: ItemAlign.Start }
          // children: 3
          Column() {
            // === Text ===
            // props: { text: '3D Modeling' }
            // modifier: { fontSize: 14, color: '#FFFFFF', opacity: 0.7 }
            Text('3D Modeling').fontSize(14).fontColor('#FFFFFF').opacity(0.7)

            // === Text ===
            // props: { text: 'Blender Basic' }
            // modifier: { fontSize: 22, fontWeight: FontWeight.Bold, color: '#FFFFFF' }
            Text('Blender Basic').fontSize(22).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')

            // === Row ===
            // props: { space: 8 }
            // modifier: { width: '100%', marginTop: 8 }
            // children: 2
            Row() {
              // === Text ===
              // props: { text: '75%' }
              // modifier: { fontSize: 12, color: '#FFFFFF' }
              Text('75%').fontSize(12).fontColor('#FFFFFF')
              
              // === Progress ===
              // props: { value: 75, total: 100, type: ProgressType.Linear }
              // modifier: { width: '100%', height: 6, color: '#FFA726', trackColor: '#FFFFFF', opacity: 0.2 }
              Progress({ value: 75, total: 100, type: ProgressType.Linear }).width('100%').height(6).color('#FFA726').trackColor('#FFFFFF').opacity(0.2)
            }.width('100%').margin({ top: 8 })
          }.layoutWeight(1)

          // === Circle ===
          // modifier: { width: 60, height: 60, backgroundColor: '#FFF' }
          // children: 1
          Circle()
            .width(60).height(60).backgroundColor('#FFF')
            
          // === Image ===
          // modifier: { width: 32, height: 32, colorFilter: { sourceColor: '#4E31AA', mode: ImageColorFilterMode.SRC_IN } }
          Image($r('app.media.startIcon')).width(32).height(32).colorFilter({ sourceColor: '#4E31AA', mode: ImageColorFilterMode.SrcIn })
        }.width('100%').padding(20)
      }.width('100%').height(140).backgroundColor('#4E31AA').borderRadius(24)
    }.width('100%').padding(24)
  }
}

@Component
struct CategoriesSection {
  private categories = ['Coding', 'Design', 'Business', 'Photo', 'Music']

  build() {
    // === Scroll ===
    // props: { scroller: Scroller.new(), edgeEffect: EdgeEffect.Spring }
    // modifier: { width: '100%' }
    // children: 1
    Scroll() {
      // === Row ===
      // props: { space: 12 }
      // modifier: { width: '100%', padding: { left: 24, right: 24 } }
      // children: 5
      Row() {
        ForEach(this.categories, (item: string) => {
          // === Text ===
          // props: { text: item }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, padding: { left: 24, right: 24, top: 12, bottom: 12 }, borderRadius: 12, backgroundColor: item === 'Design' ? '#FF7043' : '#FFF', color: item === 'Design' ? '#FFF' : '#9E9E9E' }
          Text(item)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .borderRadius(12)
            .backgroundColor(item === 'Design' ? '#FF7043' : '#FFF')
            .fontColor(item === 'Design' ? '#FFF' : '#9E9E9E')
        })
      }.width('100%').padding({ left: 24, right: 24 })
    }
  }
}

interface CourseData {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;
  iconName: string;
}

@Component
struct RecommendedSection {
  private courses: Array<CourseData> = [
    { title: 'Mobile Dev', subtitle: 'Android Compose', rating: '4.9', bgColor: '#E3F2FD', accentColor: '#1565C0', iconName: 'checkmark.circle.fill' },
    { title: 'Photography', subtitle: 'Master Lighting', rating: '4.7', bgColor: '#FCE4EC', accentColor: '#C2185B', iconName: 'star.fill' },
    { title: 'Finance', subtitle: 'Crypto Trading', rating: '4.5', bgColor: '#E8F5E9', accentColor: '#2E7D32', iconName: 'star.fill' }
  ]

  build() {
    // === Column ===
    // props: { space: 16 }
    // modifier: { width: '100%', padding: 24, alignItems: ItemAlign.Start }
    // children: 2
    Column() {
      // === Row ===
      // props: { space: 16 }
      // modifier: { width: '100%' }
      // children: 2
      Row() {
        // === Text ===
        // props: { text: 'Recommended' }
        // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, color: '#1C1B1F' }
        Text('Recommended').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#1C1B1F')
        
        // === Blank ===
        Blank()
        
        // === Text ===
        // props: { text: 'See all' }
        // modifier: { color: '#9E9E9E' }
        Text('See all').fontColor('#9E9E9E')
      }.width('100%')

      // === Column ===
      // props: { space: 16 }
      // modifier: { width: '100%' }
      // children: 3
      Column() {
        ForEach(this.courses, (course: CourseData) => {
          // === CourseCard ===
          // props: { course: course }
          // children: 1
          CourseCard({ course: course })
        })
      }.width('100%')
    }.width('100%').padding(24)
  }
}

@Component
struct CourseCard {
  @Prop course: CourseData

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Start }
    // modifier: { width: '100%', height: 100, backgroundColor: '#FFF', borderRadius: 20 }
    // children: 1
    Stack() {
      // === Row ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%' }
      // children: 3
      Row() {
        // === Rectangle ===
        // modifier: { width: 100, height: '100%', backgroundColor: this.course.bgColor, borderRadius: { topLeft: 20, bottomLeft: 20 } }
        // children: 1
        Rect()
          .width(100).height('100%').fill(this.course.bgColor).borderRadius({ topLeft: 20, bottomLeft: 20 })
        
        // === Image ===
        // modifier: { width: 32, height: 32, colorFilter: { sourceColor: this.course.accentColor, mode: ImageColorFilterMode.SRC_IN } }
        Image($r('app.media.startIcon')).width(32).height(32).colorFilter({ sourceColor: this.course.accentColor, mode: ImageColorFilterMode.SrcIn })

        // === Column ===
        // props: { space: 4 }
        // modifier: { layoutWeight: 1, padding: 16, alignItems: ItemAlign.Start }
        // children: 3
        Column() {
          // === Text ===
          // props: { text: this.course.subtitle }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Bold, color: '#4E31AA' }
          Text(this.course.subtitle).fontSize(12).fontWeight(FontWeight.Bold).fontColor('#4E31AA')
          
          // === Text ===
          // props: { text: this.course.title }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, color: '#1C1B1F' }
          Text(this.course.title).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#1C1B1F')
          
          // === Row ===
          // props: { space: 4 }
          // children: 2
          Row() {
            // === Image ===
            // modifier: { width: 12, height: 12, colorFilter: { sourceColor: '#FFB300', mode: ImageColorFilterMode.SRC_IN } }
            Image($r('app.media.startIcon')).width(12).height(12).colorFilter({ sourceColor: '#FFB300', mode: ImageColorFilterMode.SrcIn })
            
            // === Text ===
            // props: { text: this.course.rating }
            // modifier: { fontSize: 12, color: '#9E9E9E' }
            Text(this.course.rating).fontSize(12).fontColor('#9E9E9E')
          }
        }.layoutWeight(1).padding(16)

        // === Image ===
        // modifier: { width: 24, height: 24, colorFilter: { sourceColor: '#EEEEEE', mode: ImageColorFilterMode.SRC_IN }, margin: { right: 16 } }
        Image($r('app.media.startIcon')).width(24).height(24).colorFilter({ sourceColor: '#EEEEEE', mode: ImageColorFilterMode.SrcIn }).margin({ right: 16 })
      }.width('100%').height('100%')
    }.width('100%').height(100).backgroundColor('#FFF').borderRadius(20)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    // === Row ===
    // props: { space: 24 }
    // modifier: { width: '100%', height: 64, padding: { left: 24, right: 24 }, backgroundColor: '#1E1E1E', borderRadius: 32, shadow: { radius: 8, color: '#33000000', offsetY: 4 } }
    // children: 4
    Row() {
      // === Image ===
      // modifier: { width: 24, height: 24, colorFilter: { sourceColor: '#FFF', mode: ImageColorFilterMode.SRC_IN } }
      Image($r('app.media.startIcon')).width(24).height(24).colorFilter({ sourceColor: '#FFF', mode: ImageColorFilterMode.SrcIn })
      
      // === Image ===
      // modifier: { width: 24, height: 24, colorFilter: { sourceColor: '#9E9E9E', mode: ImageColorFilterMode.SRC_IN } }
      Image($r('app.media.startIcon')).width(24).height(24).colorFilter({ sourceColor: '#9E9E9E', mode: ImageColorFilterMode.SrcIn })
      
      // === Image ===
      // modifier: { width: 24, height: 24, colorFilter: { sourceColor: '#9E9E9E', mode: ImageColorFilterMode.SRC_IN } }
      Image($r('app.media.startIcon')).width(24).height(24).colorFilter({ sourceColor: '#9E9E9E', mode: ImageColorFilterMode.SrcIn })
      
      // === Image ===
      // modifier: { width: 24, height: 24, colorFilter: { sourceColor: '#9E9E9E', mode: ImageColorFilterMode.SRC_IN } }
      Image($r('app.media.startIcon')).width(24).height(24).colorFilter({ sourceColor: '#9E9E9E', mode: ImageColorFilterMode.SrcIn })
    }.width('100%').height(64).padding({ left: 24, right: 24 }).backgroundColor('#1E1E1E').borderRadius(32).shadow({ radius: 8, color: '#33000000', offsetY: 4 })
  }
}