// ChangelogPage.ets
import { BusinessError } from '@kit.BasicServicesKit';

interface VersionEntry {
  version: string;
  changes: string[];
}

@Entry
@Component
struct ChangelogPage {
  @State changelog: VersionEntry[] = [
    {
      version: "1.3.0",
      changes: [
        "Added biometric lock support",
        "New palette styles: Rainbow, Fruit Salad",
        "Improved backup & restore performance",
        "Fixed notification scheduling bug"
      ]
    },
    {
      version: "1.2.0",
      changes: [
        "Introduced Material You theming",
        "Added font picker with 8 font choices",
        "Export/import settings backup",
        "Redesigned habit analytics page"
      ]
    },
    {
      version: "1.1.0",
      changes: [
        "Added habit calendar view",
        "Overall analytics page",
        "Bug fixes and performance improvements"
      ]
    },
    {
      version: "1.0.0",
      changes: ["Initial release", "Basic habit tracking", "Task management"]
    }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Button() {
          Text('←')
            .fontSize(24)
            .fontColor('#1C1B1F')
        }
        .type(ButtonType.Circle)
        .backgroundColor('#E6E0F8')
        .width(48)
        .height(48)
        .onClick(() => {
          console.info("Back clicked");
        })

        Text('Changelog')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ left: 16 })
      }
      .width('100%')
      .padding({ top: 50, bottom: 16, left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)

      // Content List
      Scroll() {
        Column({ space: 16 }) {
          ForEach(this.changelog, (entry: VersionEntry) => {
            Column() {
              // Version Header
              Text(entry.version)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
                .margin({ top: 16, bottom: 8 })

              // Changes List
              Column({ space: 2 }) {
                ForEach(entry.changes, (change: string, index: number) => {
                  ListItemComponent(change, entry.changes.length, index)
                })
              }
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
          })
          
          // Bottom padding to match screenshot scroll area
          Blank().height(60)
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FCF2FF') // Light purple background matching the screenshot
  }
}

@Component
struct ListItemComponent {
  private text: string = '';
  private totalItems: number = 0;
  private currentIndex: number = 0;

  constructor(text: string, totalItems: number, currentIndex: number) {
    super();
    this.text = text;
    this.totalItems = totalItems;
    this.currentIndex = currentIndex;
  }

  build() {
    Text(this.text)
      .fontSize(20)
      .fontColor('#1C1B1F')
      .lineHeight(28)
      .width('100%')
      .textAlign(TextAlign.Start)
      .padding({ top: 12, bottom: 12, left: 16, right: 16 })
      .borderRadius(this.getBorderRadius())
      .backgroundColor('#FFFFFF')
  }

  private getBorderRadius(): number {
    if (this.totalItems === 1) return 28;
    
    // Simplified approach for visual fidelity:
    // First item: top rounded
    // Last item: bottom rounded
    // Middle: none
    
    if (this.currentIndex === 0 && this.totalItems > 1) {
       return 28; 
    } else if (this.currentIndex === this.totalItems - 1) {
       return 28;
    } else {
       return 0;
    }
  }
}