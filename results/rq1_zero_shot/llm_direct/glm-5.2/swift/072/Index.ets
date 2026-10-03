// ReliefFundApp.ets
import { 
  Length, 
  ResourceStr, 
  Color as ArkColor, 
  CommonBackgroundColor 
} from '@ohos.arkui';

// MARK: - Color Palette Helper
function hexToColor(hex: string): ResourceColor {
  const sanitized = hex.replace('#', '');
  const fullHex = sanitized.length === 3 
    ? sanitized.split('').map(c => c + c).join('') 
    : sanitized;
  
  const r = parseInt(fullHex.substring(0, 2), 16);
  const g = parseInt(fullHex.substring(2, 4), 16);
  const b = parseInt(fullHex.substring(4, 6), 16);
  
  return `#${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}`;
}

// MARK: - Color Constants
class RFColors {
  static readonly background: ResourceColor = hexToColor('FBF8F3');
  static readonly cardBg: ResourceColor = hexToColor('F7F3EE');
  static readonly headerCircle: ResourceColor = hexToColor('EBE2D6');
  static readonly summaryRow: ResourceColor = hexToColor('EBE2D6');
  static readonly textDark: ResourceColor = hexToColor('3D352E');
  static readonly textGray: ResourceColor = hexToColor('8A8A8E');
  static readonly placeholder: ResourceColor = hexToColor('6D5F58');
  static readonly border: ResourceColor = hexToColor('C5B8A9');
  static readonly buttonBack: ResourceColor = hexToColor('EBE2D6');
  static readonly buttonNext: ResourceColor = hexToColor('B58B5A');
}

// MARK: - Main Entry Point
@Entry
@Component
struct ReliefFundApp {
  build() {
    Column() {
      ContentView()
    }
    .backgroundColor(RFColors.background)
    .width('100%')
    .height('100%');
  }
}

// MARK: - Main Content View
@Component
struct ContentView {
  build() {
    Column() {
      // Header
      HeaderView()
        .padding({ top: 10, bottom: 20 });

      // Scrollable Content
      Scroll() {
        Column() {
          // Main Form Card
          ApplicantDetailsCard();

          // Summary Card
          SummaryCard();
        }
        .padding({ left: 16, right: 16, bottom: 40 });
      }
      .scrollBar(BarState.Off);
    }
    .width('100%')
    .height('100%');
  }
}

// MARK: - Header View
@Component
struct HeaderView {
  build() {
    Row() {
      // Left Circle
      Circle()
        .fill(RFColors.headerCircle)
        .width(48)
        .height(48);

      // Spacer
      Blank();

      // Title Container
      Column() {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(RFColors.textDark);
        
        Text('Civic support intake')
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(RFColors.textGray);
      }
      .alignItems(HorizontalAlign.Center);

      // Spacer
      Blank();

      // Right Circle
      Circle()
        .fill(RFColors.headerCircle)
        .width(48)
        .height(48);
    }
    .width('100%')
    .padding({ left: 24, right: 24 });
  }
}

// MARK: - Applicant Details Card
@Component
struct ApplicantDetailsCard {
  @State fullName: string = '';
  @State organization: string = '';
  @State contact: string = '';
  @State narrative: string = '';

  build() {
    Column() {
      // Title
      Text('Applicant details')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(RFColors.textDark)
        .padding({ bottom: 4 });

      // Form Fields
      CustomTextField({ placeholder: 'Full name', text: this.fullName, height: 18 });
      CustomTextField({ placeholder: 'Organization', text: this.organization, height: 18 });
      CustomTextField({ placeholder: 'Contact', text: this.contact, height: 18 });
      
      // Narrative Field
      Column() {
        CustomTextField({ placeholder: 'Relief narrative', text: this.narrative, height: 18 });
      }
      .padding({ bottom: 90 });

      // Navigation Buttons
      Row() {
        FormButton({ label: 'Back', isPrimary: false });
        Blank();
        FormButton({ label: 'Next', isPrimary: true });
      }
      .padding({ top: 80 });
    }
    .padding(24)
    .backgroundColor(RFColors.cardBg)
    .borderRadius(32)
    .alignItems(HorizontalAlign.Start);
  }
}

// MARK: - Summary Card
@Component
struct SummaryCard {
  build() {
    Column() {
      // Title
      Text('Summary')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(RFColors.textDark);

      // Summary Row
      SummaryRow({ label: 'Requested', value: '$4,500' });
    }
    .padding(24)
    .backgroundColor(RFColors.cardBg)
    .borderRadius(32)
    .alignItems(HorizontalAlign.Start);
  }
}

// MARK: - Custom Text Field
@Component
struct CustomTextField {
  @Prop placeholder: string;
  @Prop text: string;
  @Prop height: number = 40;
  
  build() {
    TextInput({ placeholder: this.placeholder, text: this.text })
      .fontSize(16)
      .fontColor(RFColors.textDark)
      .padding({ left: 16, right: 16 })
      .height(this.height)
      .backgroundColor(RFColors.background)
      .borderRadius(16)
      .border({ width: 1.5, color: RFColors.border });
  }
}

// MARK: - Form Button
@Component
struct FormButton {
  @Prop label: string;
  @Prop isPrimary: boolean;

  build() {
    Button(this.label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(Color.Black)
      .padding({ top: 48, bottom: 48 })
      .width('45%')
      .backgroundColor(this.isPrimary ? RFColors.buttonNext : RFColors.buttonBack)
      .borderRadius(16);
  }
}

// MARK: - Summary Row
@Component
struct SummaryRow {
  @Prop label: string;
  @Prop value: string;

  build() {
    Row() {
      Text(this.label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(RFColors.textDark);
      
      Blank();
      
      Text(this.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black);
    }
    .padding(20)
    .backgroundColor(RFColors.summaryRow)
    .borderRadius(16)
    .width('100%');
  }
}