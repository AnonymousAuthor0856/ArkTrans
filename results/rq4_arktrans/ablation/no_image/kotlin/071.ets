@Entry
@Component
struct Index {
  @State questionCategory: string = 'question.category'
  @State progressPercent: string = '45%'
  @State syncProgress: number = 0.3
  @State questionPrompt: string = 'question.prompt'
  @State selectedOption: string = ''
  @State currentQuestionIndex: number = 0
  @State trackersTitle: string = 'Trackers'
  @State streakLabel: string = 'streak.label'
  @State streakValue: string = 'streak.value'
  @State submitButtonText: string = 'Submit answer'
  @State appTitle: string = 'QuizForge'
  @State appSubtitle: string = 'Aroma sprint'

  // Mock data for lists to ensure compilation without external dependencies
  private options: string[] = ['Option A', 'Option B', 'Option C']
  private streaks: StreakItem[] = [
    { label: 'Day 1', value: '1' },
    { label: 'Day 2', value: '2' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // === Surface (Card-like container) ===
        Column() {
          Column({ space: 8 }) {
            // Header Row
            Row({ space: 0 }) {
              Text(this.questionCategory)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#311F10')
              Blank()
              Text(this.progressPercent)
                .fontSize(14)
                .fontColor('#FFC857')
            }.width('100%').alignItems(VerticalAlign.Center)

            // Progress Bar
            Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
              .width('100%')
              .height(4)
              .color('#FF8A2A')

            // Question Prompt
            Text(this.questionPrompt)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#311F10')
              .margin({ top: 8 })

            // Options List
            Column({ space: 4 }) {
              ForEach(this.options, (option: string) => {
                Column() {
                  Text(option)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#311F10')
                }
                .width('100%')
                .backgroundColor(this.selectedOption === option ? '#FFF0E0' : '#F5F5F5')
                .borderRadius(8)
                .border({ width: 1, color: this.selectedOption === option ? '#FF8A2A' : '#E0E0E0' })
                .padding(12)
                .onClick(() => {
                  this.selectedOption = option
                })
              })
            }

            // Hint Box
            Column() {
              Text(`Hint: ${this.questionPrompt.substring(0, 10)}...`)
                .fontSize(12)
                .fontColor('#311F10')
            }
            .width('100%')
            .backgroundColor('#FFE0B2')
            .borderRadius(4)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .margin({ top: 8 })
          }
          .padding(16)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1A000000' })
        .margin({ bottom: 16 })

        // Trackers Surface
        Column() {
          Column({ space: 4 }) {
            Text(this.trackersTitle)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#311F10')

            Row({ space: 8 }) {
              ForEach(this.streaks, (streak: StreakItem) => {
                Column({ space: 2 }) {
                  Text(streak.label)
                    .fontSize(12)
                    .fontColor('#311F10')
                  Text(streak.value)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#311F10')
                }
                .alignItems(HorizontalAlign.Center)
                .layoutWeight(1)
                .backgroundColor('#F5F5F5')
                .borderRadius(8)
                .padding(12)
              })
            }

            Button() {
              Text(this.submitButtonText)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .width('100%')
            .backgroundColor('#FF8A2A')
            .borderRadius(8)
            .margin({ top: 16 })
            .onClick(() => {
              // Submit logic
            })
          }
          .padding(16)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1A000000' })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 12 })
      .backgroundColor('#FFF9F2')

      // Top App Bar Area (Simulated with absolute positioning or separate stack layer if needed, 
      // but here integrated into the main flow or overlaid as per skeleton structure)
      // The skeleton shows CenterAlignedTopAppBar inside the Stack alongside the Column.
      // In ArkTS, we can place it at the top of the Stack.
      
      Column() {
        Column({ space: 0 }) {
          Text(this.appTitle)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#311F10')
          Text(this.appSubtitle)
            .fontSize(12)
            .fontColor('#311F10')
        }
        .alignItems(HorizontalAlign.Center)
        
        // Spacer to push buttons to the right if using a Row, 
        // but the skeleton implies a specific layout. 
        // Let's create a Row for the AppBar content to match "CenterAligned" behavior roughly
      }
      .position({ x: 0, y: 0 })
      .width('100%')
      .height(60)
      .backgroundColor('#FFF9F2')
      .zIndex(1)
      
      // Re-structuring the AppBar to be a proper overlay row
      Row() {
        Column({ space: 0 }) {
          Text(this.appTitle)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#311F10')
          Text(this.appSubtitle)
            .fontSize(12)
            .fontColor('#311F10')
        }
        .alignItems(HorizontalAlign.Center)
        
        Blank()
        
        // IconButton 1
        Button() {
          Stack() {
            // Placeholder for icon
          }
          .width(30)
          .height(30)
          .backgroundColor('#F5F5F5')
          .borderRadius(15)
        }
        .type(ButtonType.Circle)
        .backgroundColor(Color.Transparent)
        
        // IconButton 2
        Button() {
          Stack() {
            // Placeholder for icon
          }
          .width(30)
          .height(30)
          .backgroundColor('#FF8A2A')
          .opacity(0.35)
          .borderRadius(15)
        }
        .type(ButtonType.Circle)
        .backgroundColor(Color.Transparent)
        .margin({ left: 8 })
      }
      .width('100%')
      .height(60)
      .padding({ left: 20, right: 20 })
      .alignItems(VerticalAlign.Center)
      .position({ x: 0, y: 0 })
      .zIndex(2)
    }
    .width('100%')
    .height('100%')
  }
}

interface StreakItem {
  label: string;
  value: string;
}