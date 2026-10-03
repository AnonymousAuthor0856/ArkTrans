@Entry
@Component
struct Index {
  @State selectedIndex: number = 0

  build() {
    Stack() {
      Stack() {
        Column({ space: 0 }) {
          Row() {
            .alignItems(VerticalAlign.Center)
            Column({ space: 4 }) {
              .alignItems(HorizontalAlign.Start)
              Text('Tea Master')
                .fontColor(Color.Black)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
              Text('Perfect brew, every time')
                .fontColor(Color.Gray)
                .fontSize(12)
            }
            Blank()
            Button() {}
          }

          Blank().height(32)

          Stack() {
            Circle()
              .width(220)
              .height(220)
              .fill('#F5F5F5') // Approximation of rgb(0.96, 0.96, 0.96)

            Column({ space: 8 }) {
              Image($r('app.media.startIcon')) // Using allowed resource as placeholder for heart.fill
                .width(48)
                .height(48)
                .objectFit(ImageFit.Contain)
              
              Text('Earl Grey') // Placeholder for tea.name
                .fontColor(Color.Black)
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
            }
          }

          Blank().height(40)

          Row() {
            InfoItem({ props: { label: 'TEMP', value: '95°C' } })
            Blank()
            VerticalDivider()
            Blank()
            InfoItem({ props: { label: 'TIME', value: '3 min' } })
            Blank()
            VerticalDivider()
            Blank()
            InfoItem({ props: { label: 'AMOUNT', value: '250ml' } })
          }

          Blank().height(40)

          Column({ space: 12 }) {
            .alignItems(HorizontalAlign.Start)
            Text('Select Variety')
              .padding({ left: 4 })
              .fontColor(Color.Black)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)

            Scroll(new Scroller()) {
              Row({ space: 12 }) {
                ForEach([0, 1, 2], (index: number) => {
                  TeaChip({ 
                    props: {
                      name: index === 0 ? 'Green' : index === 1 ? 'Black' : 'Oolong', 
                      isSelected: this.selectedIndex === index, 
                      onClick: () => { this.selectedIndex = index } 
                    }
                  })
                })
              }.padding({ left: 4, right: 4 })
            }
            .scrollBar(BarState.Off)
            .scrollable(ScrollDirection.Horizontal)
          }

          Blank()

          Button() {
            Row({ space: 8 }) {
              Image($r('app.media.startIcon')) // Using allowed resource as placeholder for play.fill
                .width(20)
                .height(20)
              Text('START TIMER')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .height(56)
            .backgroundColor(Color.Black)
            .borderRadius(16)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
        }
      }
    }.width('100%').height('100%')
  }
}

interface InfoItemProps {
  label: string;
  value: string;
}

@Component
struct InfoItem {
  private props: InfoItemProps = { label: '', value: '' }

  build() {
    Column({ space: 4 }) {
      Text(this.props.label)
        .fontSize(12)
        .fontColor(Color.Gray)
      Text(this.props.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
    }
  }
}

@Component
struct VerticalDivider {
  build() {
    Divider()
      .vertical(true)
      .color(Color.Gray)
      .opacity(0.3)
      .margin({ top: 8, bottom: 8 })
  }
}

interface TeaChipProps {
  name: string;
  isSelected: boolean;
  onClick: () => void;
}

@Component
struct TeaChip {
  private props: TeaChipProps = { name: '', isSelected: false, onClick: () => {} }

  build() {
    Button(this.props.name) {
      Text(this.props.name)
        .fontSize(14)
        .fontColor(this.props.isSelected ? Color.White : Color.Black)
    }
    .backgroundColor(this.props.isSelected ? '#8C6E63' : '#F5F5F5')
    .borderRadius(20)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .onClick(this.props.onClick)
  }
}