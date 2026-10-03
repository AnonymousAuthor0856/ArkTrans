// QuizForge.ets
interface QuizQuestion {
  category: string;
  prompt: string;
  options: string[];
  hint: string;
}

interface StreakCard {
  label: string;
  value: string;
}

@Entry
@Component
struct QuizForge {
  // State
  @State selectedIndex: number = -1;
  private progress: number = 0.45;

  private question: QuizQuestion = {
    category: "Citrus crafts",
    prompt: "Which zest carrier gives the brightest aroma when infused cold?",
    options: ["Dried peel sachet", "Twist garnish", "Zester microplane", "Candied strip"],
    hint: "Think surface area"
  };

  private streaks: StreakCard[] = [
    { label: "Current streak", value: "5 days" },
    { label: "Accuracy", value: "84%" },
    { label: "Rank", value: "Top 12%" }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation Icon
        Circle({ width: 30, height: 30 })
          .fillColor("#FFE4CC");

        // Title
        Column() {
          Text("QuizForge")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor("#311F10");
          Text("Aroma sprint")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .opacity(0.7)
            .fontColor("#311F10");
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center);

        // Action Icon
        Circle({ width: 30, height: 30 })
          .fillColor("#FF8A2A")
          .opacity(0.35);
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      // Scrollable Content
      Scroll() {
        Column({ space: 16 }) {
          
          // Question Card
          Column({ space: 12 }) {
            Row() {
              Text(this.question.category)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor("#311F10");
              Text("45%")
                .fontSize(14)
                .fontColor("#FFC857");
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween);

            // Progress Bar
            Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
              .color("#FF8A2A")
              .width('100%')
              .height(4);

            Text(this.question.prompt)
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor("#311F10");

            // Options
            Column({ space: 8 }) {
              ForEach(this.question.options, (option: string, index: number) => {
                Text(option)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#311F10")
                  .width('100%')
                  .padding(12)
                  .borderRadius(18)
                  .backgroundColor(this.selectedIndex === index ? "#33FF8A2A" : "#FFE4CC")
                  .border({
                    width: 1,
                    color: this.selectedIndex === index ? "#FF8A2A" : "#E2B088",
                    radius: 18
                  })
                  .onClick(() => {
                    this.selectedIndex = index;
                  });
              });
            }

            // Hint
            Text(`Hint: ${this.question.hint}`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor("#311F10")
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .borderRadius(10)
              .backgroundColor("#33FFC857");
          }
          .width('100%')
          .padding(16)
          .borderRadius(28)
          .backgroundColor("#FFFFFF")
          .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 });

          // Trackers Card
          Column({ space: 8 }) {
            Text("Trackers")
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor("#311F10");

            Row({ space: 12 }) {
              ForEach(this.streaks, (streak: StreakCard) => {
                Column({ space: 4 }) {
                  Text(streak.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .opacity(0.7)
                    .fontColor("#311F10");
                  Text(streak.value)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor("#311F10");
                }
                .layoutWeight(1)
                .padding(12)
                .borderRadius(18)
                .backgroundColor("#FFE4CC")
                .alignItems(HorizontalAlign.Center);
              });
            }
            .width('100%');

            // Submit Button
            Button("Submit answer")
              .width('100%')
              .height(48)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor("#2C0D00")
              .backgroundColor("#FF8A2A")
              .borderRadius(18);
          }
          .width('100%')
          .padding(16)
          .borderRadius(28)
          .backgroundColor("#FFFFFF")
          .shadow({ radius: 4, color: '#33000000', offsetX: 0, offsetY: 2 });

        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 12, bottom: 12 });
      }
      .layoutWeight(1)
      .backgroundColor("#FFF9F2");
    }
    .height('100%')
  }
}