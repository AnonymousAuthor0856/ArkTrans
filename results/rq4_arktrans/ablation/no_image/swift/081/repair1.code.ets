@Entry
@Component
struct Index {
  @State categories: string[] = ['All', 'Work', 'Personal', 'Study']

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Button('Menu')
            .backgroundColor(Color.Transparent)
            .borderRadius(8)
            .width(40)
            .height(40)
          
          Blank()
          
          Button('Profile')
            .backgroundColor(Color.Transparent)
            .borderRadius(8)
            .width(40)
            .height(40)
        }
        .padding({ left: 24, right: 24, top: 16 })

        Scroll() {
          Column() {
            Blank().height(16)

            Column() {
              Text('Hello, Alex')
                .fontColor('#000000')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
              
              Text('You have 5 incomplete tasks today.')
                .fontColor('#999999')
                .fontSize(16)
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)

            Blank().height(32)

            Scroll({ scroller: new Scroller() }) {
              Row({ space: 12 }) {
                ForEach(this.categories, (category: string) => {
                  Text(category)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FFFFFF')
                    .backgroundColor('#E0E0E0')
                    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                    .borderRadius(20)
                })
              }
            }
            .scrollBar(BarState.Off)
            .width('100%')

            Blank().height(24)

            Column() {
              Text('Recent Tasks')
                .fontColor('#000000')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: 0 })

              TaskItem({
                props: {
                  title: 'Team Meeting',
                  time: '10:00 AM - 11:30 AM',
                  tag: 'Work',
                  tagColor: '#E3F2FD',
                  tagTextColor: '#1565C0',
                  isChecked: false
                }
              })

              TaskItem({
                props: {
                  title: 'Design Review',
                  time: '02:00 PM - 03:00 PM',
                  tag: 'Design',
                  tagColor: '#F3E5F5',
                  tagTextColor: '#7B1FA2',
                  isChecked: true
                }
              })

              TaskItem({
                props: {
                  title: 'Grocery Shopping',
                  time: '05:30 PM',
                  tag: 'Personal',
                  tagColor: '#E8F5E9',
                  tagTextColor: '#2E7D32',
                  isChecked: false
                }
              })

              TaskItem({
                props: {
                  title: 'Read Documentation',
                  time: '08:00 PM',
                  tag: 'Study',
                  tagColor: '#FFF3E0',
                  tagTextColor: '#EF6C00',
                  isChecked: true
                }
              })
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)

            Blank().height(80)
          }
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
      }

      Button('+')
        .width(56)
        .height(56)
        .backgroundColor('#6750A4')
        .borderRadius(28)
        .fontColor('#FFFFFF')
        .fontSize(24)
        .margin({ bottom: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
  }
}

interface TaskItemProps {
  title: string;
  time: string;
  tag: string;
  tagColor: string;
  tagTextColor: string;
  isChecked: boolean;
}

@Component
struct TaskItem {
  private props: TaskItemProps = {
    title: '',
    time: '',
    tag: '',
    tagColor: '',
    tagTextColor: '',
    isChecked: false
  }

  build() {
    Row() {
      Circle()
        .width(24)
        .height(24)
        .fill(this.props.isChecked ? '#6750A4' : Color.Transparent)
        .borderWidth(2)
        .borderColor(this.props.isChecked ? '#6750A4' : '#CCCCCC')
      
      Column() {
        Text(this.props.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        
        Text(this.props.time)
          .fontSize(14)
          .fontColor('#999999')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 12 })

      Text(this.props.tag)
        .fontSize(12)
        .fontColor(this.props.tagTextColor)
        .backgroundColor(this.props.tagColor)
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .borderRadius(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 2, color: '#1F000000', offsetY: 2 })
    .margin({ bottom: 12 })
  }
}