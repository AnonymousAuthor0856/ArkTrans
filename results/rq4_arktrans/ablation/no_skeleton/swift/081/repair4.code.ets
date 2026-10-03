import { Scroller, ScrollDirection } from '@kit.ArkUI'

@Entry
@Component
struct TaskDashboardScreen {
  @State categories: string[] = ["All", "Work", "Personal", "Design"]
  @State selectedCategoryIndex: number = 0

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.BottomEnd }
    // children: 2
    Stack({ alignContent: Alignment.BottomEnd }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%' }
      // children: 2
      Column({ space: 0 }) {
        // === Row ===
        // props: { space: 0 }
        // modifier: { width: '100%', padding: { top: 48, left: 24, right: 24, bottom: 16 } }
        // children: 3
        Row({ space: 0 }) {
          // === Button (Menu) ===
          // modifier: { width: 48, height: 48, backgroundColor: '#F5F5F5', borderRadius: 24 }
          // children: 1
          Button() {
            // === Image ===
            // modifier: { width: 24, height: 24 }
            Image($r('app.media.startIcon'))
              .width(24).height(24)
              .objectFit(ImageFit.Contain)
          }.width(48).height(48).backgroundColor('#F5F5F5').borderRadius(24)

          // === Blank ===
          Blank()

          // === Button (Search) ===
          // modifier: { width: 48, height: 48, backgroundColor: '#F5F5F5', borderRadius: 24 }
          // children: 1
          Button() {
            // === Image ===
            // modifier: { width: 24, height: 24 }
            Image($r('app.media.startIcon'))
              .width(24).height(24)
              .objectFit(ImageFit.Contain)
          }.width(48).height(48).backgroundColor('#F5F5F5').borderRadius(24)
        }

        // === Scroll ===
        // props: { scrollable: ScrollDirection.Vertical, barWidth: 0 }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 1
        Scroll(new Scroller(), ScrollDirection.Vertical) {
          // === Column ===
          // props: { space: 0 }
          // modifier: { width: '100%', padding: { left: 24, right: 24 } }
          // children: 7
          Column({ space: 0 }) {
            // === Blank ===
            // modifier: { height: 16 }
            Blank().height(16)

            // === Column (Welcome) ===
            // props: { space: 8 }
            // children: 2
            Column({ space: 8 }) {
              // === Text ===
              // props: { text: 'Hello, Alex' }
              // modifier: { fontSize: 32, fontWeight: FontWeight.Bold, color: '#000' }
              Text('Hello, Alex')
                .fontSize(32).fontWeight(FontWeight.Bold).fontColor('#000')

              // === Text ===
              // props: { text: 'You have 5 incomplete tasks today.' }
              // modifier: { fontSize: 16, color: '#999' }
              Text('You have 5 incomplete tasks today.')
                .fontSize(16).fontColor('#999')
            }

            // === Blank ===
            // modifier: { height: 32 }
            Blank().height(32)

            // === Scroll (Categories) ===
            // props: { scrollable: ScrollDirection.Horizontal, barWidth: 0 }
            // modifier: { width: '100%' }
            // children: 1
            Scroll(new Scroller(), ScrollDirection.Horizontal) {
              // === Row ===
              // props: { space: 12 }
              // children: 4
              Row({ space: 12 }) {
                ForEach(this.categories.map((c, i) => ({ name: c, index: i })), (item: CategoryItem) => {
                  // === Button ===
                  // modifier: { backgroundColor: this.selectedCategoryIndex === item.index ? '#212121' : '#F5F5F5', borderRadius: 24, padding: { left: 24, right: 24, top: 12, bottom: 12 } }
                  // children: 1
                  Button(item.name) {
                    // === Text ===
                    // props: { text: item.name }
                    // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: this.selectedCategoryIndex === item.index ? '#FFF' : '#000' }
                    Text(item.name)
                      .fontSize(14).fontWeight(FontWeight.Medium)
                      .fontColor(this.selectedCategoryIndex === item.index ? '#FFF' : '#000')
                  }
                  .backgroundColor(this.selectedCategoryIndex === item.index ? '#212121' : '#F5F5F5')
                  .borderRadius(24)
                  .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                  .onClick(() => {
                    this.selectedCategoryIndex = item.index
                  })
                })
              }
            }

            // === Blank ===
            // modifier: { height: 24 }
            Blank().height(24)

            // === Column (Recent Tasks) ===
            // props: { space: 16 }
            // children: 5
            Column({ space: 16 }) {
              // === Text ===
              // props: { text: 'Recent Tasks' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, color: '#000' }
              Text('Recent Tasks')
                .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000')

              // === TaskItem 1 ===
              TaskItem({ title: 'Team Meeting', time: '10:00 AM - 11:30 AM', tag: 'Work', tagColor: '#E3F2FD', tagTextColor: '#1565C0', isChecked: true, icon: $r('app.media.startIcon') })

              // === TaskItem 2 ===
              TaskItem({ title: 'Design Review', time: '02:00 PM - 03:00 PM', tag: 'Design', tagColor: '#F3E5F5', tagTextColor: '#7B1FA2', isChecked: false, icon: $r('app.media.startIcon') })

              // === TaskItem 3 ===
              TaskItem({ title: 'Grocery Shopping', time: '05:30 PM', tag: 'Personal', tagColor: '#E8F5E9', tagTextColor: '#2E7D32', isChecked: false, icon: $r('app.media.startIcon') })

              // === TaskItem 4 ===
              TaskItem({ title: 'Read Documentation', time: '08:00 PM', tag: 'Study', tagColor: '#FFF3E0', tagTextColor: '#EF6C00', isChecked: false, icon: $r('app.media.startIcon') })
            }

            // === Blank ===
            // modifier: { height: 80 }
            Blank().height(80)
          }
        }
      }.width('100%').height('100%')

      // === Button (FAB) ===
      // modifier: { width: 56, height: 56, backgroundColor: '#212121', borderRadius: 28, margin: { right: 24, bottom: 24 }, shadow: { radius: 4, offsetY: 4, color: '#000000' } }
      // children: 1
      Button() {
        // === Image ===
        // modifier: { width: 24, height: 24 }
        Image($r('app.media.startIcon'))
          .width(24).height(24)
          .objectFit(ImageFit.Contain)
      }
      .width(56).height(56).backgroundColor('#212121').borderRadius(28)
      .margin({ right: 24, bottom: 24 })
      .shadow({ radius: 4, offsetY: 4, color: '#000000' })
    }.width('100%').height('100%')
  }
}

interface CategoryItem {
  name: string
  index: number
}

interface TaskItemProps {
  title: string
  time: string
  tag: string
  tagColor: string
  tagTextColor: string
  isChecked: boolean
  icon: Resource
}

@Component
struct TaskItem {
  private props?: TaskItemProps
  @State isChecked: boolean = false

  aboutToAppear() {
    if (this.props) {
      this.isChecked = this.props.isChecked
    }
  }

  build() {
    // === Row ===
    // props: { space: 16 }
    // modifier: { width: '100%', padding: 20, backgroundColor: '#FAFAFA', borderRadius: 20 }
    // children: 4
    Row({ space: 16 }) {
      // === Stack (Icon Box) ===
      // props: { alignContent: Alignment.Center }
      // modifier: { width: 48, height: 48 }
      // children: 2
      Stack({ alignContent: Alignment.Center }) {
        // === Rectangle ===
        // modifier: { width: 48, height: 48, backgroundColor: '#FFF', borderRadius: 14 }
        Rect()
          .width(48).height(48).fill(Color.White).borderRadius(14)

        // === Image ===
        // modifier: { width: 24, height: 24 }
        if (this.props) {
          Image(this.props.icon)
            .width(24).height(24)
            .objectFit(ImageFit.Contain)
        }
      }

      // === Column (Texts) ===
      // props: { space: 4 }
      // modifier: { layoutWeight: 1 }
      // children: 2
      Column({ space: 4 }) {
        // === Text ===
        // props: { text: this.props.title }
        // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, color: this.isChecked ? '#999' : '#000', textDecoration: this.isChecked ? TextDecorationType.LineThrough : TextDecorationType.None }
        if (this.props) {
          Text(this.props.title)
            .fontSize(16).fontWeight(FontWeight.Bold)
            .fontColor(this.isChecked ? '#999' : '#000')
            .decoration({ type: this.isChecked ? TextDecorationType.LineThrough : TextDecorationType.None })
        }

        // === Row (Time & Tag) ===
        // props: { space: 8 }
        // children: 2
        Row({ space: 8 }) {
          // === Text ===
          // props: { text: this.props.time }
          // modifier: { fontSize: 12, color: '#999' }
          if (this.props) {
            Text(this.props.time)
              .fontSize(12).fontColor('#999')
          }

          // === Text (Tag) ===
          // props: { text: this.props.tag }
          // modifier: { fontSize: 10, fontWeight: FontWeight.Bold, color: this.props.tagTextColor, backgroundColor: this.props.tagColor, borderRadius: 4, padding: { left: 6, right: 6, top: 2, bottom: 2 } }
          if (this.props) {
            Text(this.props.tag)
              .fontSize(10).fontWeight(FontWeight.Bold)
              .fontColor(this.props.tagTextColor)
              .backgroundColor(this.props.tagColor)
              .borderRadius(4)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          }
        }
      }

      // === Blank ===
      Blank()

      // === Button (Checkbox) ===
      // modifier: { width: 24, height: 24 }
      // children: 1
      Button() {
        // === Image ===
        // modifier: { width: 24, height: 24 }
        Image($r('app.media.startIcon'))
          .width(24).height(24)
          .objectFit(ImageFit.Contain)
          .opacity(this.isChecked ? 1 : 0.5)
      }
      .width(24).height(24)
      .onClick(() => {
        this.isChecked = !this.isChecked
      })
    }
    .width('100%').padding(20).backgroundColor('#FAFAFA').borderRadius(20)
  }
}