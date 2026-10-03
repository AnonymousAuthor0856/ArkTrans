// QuizApp.ets
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct QuizApp {
  @State selected: number | null = null;
  private options: string[] = ["Earth", "Mars", "Venus", "Jupiter"];
  @State reviewed: boolean = false;
  @State progress: number = 0.25;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Rect()
          .width(20)
          .height(20)
          .fill('#7C3AED')
          .borderRadius(6)
        
        Text("Quiz")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
          .margin({ left: 4 })
      }
      .justifyContent(FlexAlign.Center)
      .padding({ top: 24, bottom: 16, left: 8, right: 8 })
      .width('100%')

      // Scrollable Content
      Scroll() {
        Column() {
          // Card
          Column({ space: 8 }) {
            // Image Placeholder
            Column() {
              Text("Question 1/4")
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            .width('100%')
            .height(120)
            .backgroundColor('#F1F5F9')
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            // Question Text
            Text("Which planet is known as the Red Planet?")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0B1220')
              .textAlign(TextAlign.Start)
              .width('100%')

            // Options
            Column({ space: 4 }) {
              ForEach(this.options, (item: string, index: number) => {
                Button(item)
                  .type(ButtonType.Normal)
                  .backgroundColor(this.selected === index ? '#7C3AED' : '#FFFFFF')
                  .fontColor(this.selected === index ? '#FFFFFF' : '#0B1220')
                  .fontSize(this.selected === index ? 14 : 12)
                  .fontWeight(this.selected === index ? FontWeight.Medium : FontWeight.Regular)
                  .borderRadius(8)
                  .border({ width: 1, color: '#E2E8F0' })
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  .alignSelf(ItemAlign.Start)
                  .margin({ top: 6, bottom: 6 })
                  .onClick(() => {
                    this.selected = index;
                  })
              })
            }
            .width('100%')
          }
          .padding(8)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: '#E2E8F0' })
          .shadow({ radius: 3, color: 'rgba(0,0,0,0.08)', offsetY: 1 })
          .margin({ left: 8, right: 8 })

          // Selected + Skip
          Row() {
            Column({ space: 2 }) {
              Text("Selected")
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
              
              Text(this.selected !== null ? this.options[this.selected!] : "None")
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            
            Blank()
            
            AssistChip({ label: "Skip", isOn: false, onTap: () => {} })
          }
          .width('100%')
          .padding({ left: 8, right: 8 })
        }
        .padding({ top: 6, bottom: 120 })
      }
      .layoutWeight(1)
      
      Divider().color('#E2E8F0').margin({ top: 0, bottom: 0 })
      
      // Bottom Bar
      Row() {
        Column({ space: 2 }) {
          Text("Progress")
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
          
          Row() {
            Progress({ value: this.progress * 100, total: 100 })
              .width(140)
              .height(6)
              .color('#7C3AED')
              .trackColor('#F1F5F9')
              .control(false)
          }
          .width(140)
        }
        
        Blank()
        
        AssistChip({ label: "Review", isOn: this.reviewed, onTap: () => {
          this.reviewed = !this.reviewed;
        }})
        
        Button("Next")
          .type(ButtonType.Capsule)
          .backgroundColor('#7C3AED')
          .fontColor('#FFFFFF')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .width(140)
          .height(44)
          .borderRadius(12)
          .margin({ left: 8 })
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor('rgba(250, 250, 255, 0.65)')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFF')
  }
}

@Component
struct AssistChip {
  @Prop label: string;
  @Prop isOn: boolean;
  @Prop onTap: () => void;

  build() {
    Button(this.label)
      .type(ButtonType.Normal)
      .backgroundColor(this.isOn ? '#22C55E' : '#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E2E8F0' })
      .padding({ left: 14, right: 14, top: 10, bottom: 10 })
      .onClick(() => {
        this.onTap();
      })
  }
}