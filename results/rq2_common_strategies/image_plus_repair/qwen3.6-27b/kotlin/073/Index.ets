import { router } from '@kit.ArkUI';

// Define the color tokens matching the Kotlin source
class AppColors {
  static primary: string = '#7C3AED';
  static secondary: string = '#22D3EE';
  static tertiary: string = '#F97316';
  static background: string = '#050714';
  static surface: string = '#0F172A';
  static surfaceVariant: string = '#1F2937';
  static outline: string = '#334155';
  static onSurface: string = '#E2E8F0';
  static onSecondary: string = '#011014';
}

// Data model for chat threads
interface ChatThread {
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;
}

@Entry
@Component
struct HoloChatDock {
  @State activeFilter: string = 'Live';
  @State draftText: string = '';
  
  // Mock data corresponding to the Kotlin source
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];
  
  private threads: ChatThread[] = [
    { name: "Orbital Finance", status: "Rolling sync", unread: 5, snippet: "Need rates for Q4", isPriority: true },
    { name: "Beacon Ops", status: "Docked", unread: 0, snippet: "Switching to holo feed", isPriority: false },
    { name: "Nova Crew", status: "Hotline", unread: 2, snippet: "Uploading scan pack now", isPriority: true }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Hub')
          .fontColor(AppColors.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(12)
          .onClick(() => {})
        
        Column() {
          Text('HoloChat Dock')
            .fontColor(AppColors.onSurface)
            .fontWeight(FontWeight.Medium)
            .fontSize(16)
          Text('Dark neon bridge')
            .fontColor(Color.Gray)
            .fontSize(12)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('Status')
          .fontColor(AppColors.secondary)
          .fontWeight(FontWeight.Medium)
          .fontSize(12)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor(AppColors.surface)

      // Main Scrollable Content
      Scroll() {
        Column() {
          // Filter Chips
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.filters, (label: string) => {
              Button(label)
                .type(ButtonType.Normal)
                .backgroundColor(this.activeFilter === label ? AppColors.secondary : AppColors.surfaceVariant)
                .fontColor(this.activeFilter === label ? AppColors.onSecondary : AppColors.onSurface)
                .borderRadius(12)
                .height(32)
                .margin({ right: 8, bottom: 8 })
                .onClick(() => {
                  this.activeFilter = label;
                })
            })
          }
          .width('100%')
          .margin({ bottom: 16 })

          // Status Summary Cards
          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            this.SummaryBlock("LIVE DOCKS", "12", AppColors.secondary);
            this.SummaryBlock("ESCALATIONS", "3", AppColors.tertiary);
            this.SummaryBlock("QUEUED", "5", AppColors.primary);
          }
          .width('100%')
          .margin({ bottom: 16 })

          // Chat Thread List
          ForEach(this.threads, (thread: ChatThread) => {
            this.ChatThreadCard(thread);
          })

          // Action Footer
          this.ActionFooter();
          
          // Spacer for bottom bar clearance
          Blank().height(80);
        }
        .padding(16)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Input Bar
      Row() {
        TextInput({ placeholder: 'Message dock...' })
          .placeholderColor(Color.Gray)
          .backgroundColor(AppColors.surface)
          .borderRadius(16)
          .height(48)
          .layoutWeight(1)
          .margin({ right: 8 })
          .onChange((value: string) => {
            this.draftText = value;
          })
        
        Button('Send')
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.primary)
          .fontColor('#FFFFFF')
          .borderRadius(16)
          .height(48)
          .width(80)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(AppColors.surfaceVariant)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  SummaryBlock(title: string, value: string, accentColor: string) {
    Column() {
      Row() {
        Circle({ width: 12, height: 12 })
          .fill(accentColor)
        Text(title)
          .fontColor(Color.Gray)
          .fontSize(12)
          .margin({ left: 8 })
      }
      .margin({ bottom: 4 })
      
      Text(value)
        .fontColor(accentColor)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
    }
    .width('30%')
    .padding(12)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
  }

  @Builder
  ChatThreadCard(thread: ChatThread) {
    Column() {
      Row() {
        Column() {
          Text(thread.name)
            .fontColor(AppColors.onSurface)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
          Text(thread.status)
            .fontColor(thread.isPriority ? AppColors.secondary : Color.Gray)
            .fontSize(12)
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text(thread.unread > 0 ? `+${thread.unread}` : '✓')
          .fontColor(AppColors.onSurface)
          .fontSize(12)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
          .padding({ left: 10, right: 10, top: 6, bottom: 6 })
      }
      .width('100%')

      Text(thread.snippet)
        .fontColor(AppColors.onSurface)
        .opacity(0.9)
        .fontSize(14)
        .margin({ top: 8, bottom: 12 })

      Row() {
        Text(thread.isPriority ? 'Priority' : 'Standard')
          .fontColor(AppColors.onSurface)
          .fontSize(12)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
          .padding({ left: 10, right: 10, top: 6, bottom: 6 })
        
        Text('Open')
          .fontColor(AppColors.secondary)
          .fontSize(12)
          .margin({ left: 12 })
          .onClick(() => {})
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .borderWidth(1)
    .borderColor(AppColors.outline)
    .margin({ bottom: 16 })
  }

  @Builder
  ActionFooter() {
    Column() {
      Text('Dock filters')
        .fontColor(AppColors.onSurface)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })
      
      Row() {
        Button('Calm')
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.primary)
          .fontColor('#FFFFFF')
          .borderRadius(16)
          .height(36)
          .margin({ right: 8 })
        
        Button('Fire')
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.tertiary)
          .fontColor('#FFFFFF')
          .borderRadius(16)
          .height(36)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(20)
  }
}