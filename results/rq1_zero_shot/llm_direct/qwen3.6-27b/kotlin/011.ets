import { router } from '@kit.ArkRouter'
import { BusinessError } from '@kit.BasicServicesKit'

// --- Design Tokens & Constants ---

const AppTokens = {
  Colors: {
    primary: '#00E5FF',
    secondary: '#FF00AA',
    tertiary: '#76FF03',
    background: '#101024',
    surface: '#1C1C3A',
    surfaceVariant: '#282850',
    outline: '#44446A',
    success: '#00C853',
    warning: '#FFD600',
    error: '#FF1744',
    onPrimary: '#000000',
    onSecondary: '#000000',
    onTertiary: '#000000',
    onBackground: '#E0E0FF',
    onSurface: '#E0E0FF'
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}

// --- Data Models ---

interface Author {
  name: string;
  avatarColor: string;
}

interface Reply {
  id: number;
  author: Author;
  timestamp: string;
  text: string;
  votes: number;
}

interface Post {
  author: Author;
  timestamp: string;
  title: string;
  body: string;
  votes: number;
  commentCount: number;
}

// --- Components ---

@Component
struct UpVoteArrow {
  @Prop color: string;

  build() {
    Canvas() {
      let path = new Path();
      // Approximate size 24x24
      path.moveTo(12, 0);
      path.lineTo(24, 12);
      path.lineTo(12, 24);
      path.lineTo(0, 12);
      path.close();
    }
    .width(24)
    .height(24)
    .fill(this.color)
  }
}

@Component
struct InfoChip {
  @Prop text: string;

  build() {
    Text(this.text)
      .font-size(14)
      .fontWeight(FontWeight.Medium)
      .letterSpacing(0.5)
      .fontColor(AppTokens.Colors.outline)
  }
}

@Component
struct AuthorInfo {
  @Prop author: Author;
  @Prop timestamp: string;

  build() {
    Row() {
      Stack() {
        Circle({ radius: 12 })
          .fill(this.author.avatarColor)
        
        // Simulating the inner circle detail
        Circle({ radius: 4 })
          .fill('#000000')
          .opacity(0.2)
          .position({ x: 12, y: 12 })
      }
      .width(24)
      .height(24)

      Column() {
        Text(this.author.name)
          .font-size(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.author.avatarColor)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        
        Text(this.timestamp)
          .font-size(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.outline)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}

@Component
struct ReplyCard {
  @Prop reply: Reply;

  build() {
    Row() {
      // Vertical Line
      Rect()
        .width(2)
        .fill(Color.Transparent) // Background handled by parent or specific logic if needed, here simplified
        .border({ width: 2, color: this.reply.author.avatarColor, radius: 2 })
        .opacity(0.5)

      Column() {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })
        
        Text(this.reply.text)
          .font-size(16)
          .lineHeight(24)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.9)
          .margin({ top: 4 })

        Row() {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: 'Reply' })
        }
        .margin({ top: 8 })
        .justifyContent(FlexAlign.Start)
      }
      .layoutWeight(1)
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct PostCard {
  @Link voteState: number;
  @Prop post: Post;

  build() {
    Row() {
      // Vote Column
      Column() {
        Button() {
          UpVoteArrow({ color: this.voteState === 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline })
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.voteState = (this.voteState === 1) ? 0 : 1;
        })

        Text(`${this.post.votes + this.voteState - 1}`)
          .font-size(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)

        Button() {
          UpVoteArrow({ color: this.voteState === -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .rotate({ angle: 180 })
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.voteState = (this.voteState === -1) ? 0 : -1;
        })
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)

      // Content Column
      Column() {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })
        
        Text(this.post.title)
          .font-size(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 8 })

        Text(this.post.body)
          .font-size(16)
          .lineHeight(24)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.8)
          .margin({ top: 4 })

        Row() {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: 'Share' })
        }
        .margin({ top: 8 })
        .justifyContent(FlexAlign.Start)
      }
      .layoutWeight(1)
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .width('100%')
  }
}

@Entry
@Component
struct RootScreen {
  @State voteState: number = 1;
  
  private post: Post = {
    author: { name: "user/compose_master", avatarColor: AppTokens.Colors.tertiary },
    timestamp: "8 hours ago",
    title: "The power of Jetpack Compose for single-file UIs",
    body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    votes: 1337,
    commentCount: 42
  };

  private replies: Reply[] = [
    {
      id: 1,
      author: { name: "dev/android_fan", avatarColor: AppTokens.Colors.secondary },
      timestamp: "7h ago",
      text: "Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.",
      votes: 25
    },
    {
      id: 2,
      author: { name: "ux/designer_jane", avatarColor: AppTokens.Colors.primary },
      timestamp: "5h ago",
      text: "From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.",
      votes: 18
    },
    {
      id: 3,
      author: { name: "newbie/coder", avatarColor: AppTokens.Colors.warning },
      timestamp: "2h ago",
      text: "I found it a bit overwhelming at first. Any tips for organizing the file?",
      votes: 3
    }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('app.media.ic_back')) // Placeholder for back icon, using system default if available or custom
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.primary)
          .margin({ right: 16 })
        
        Text("r/jetpackcompose")
          .font-size(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          PostCard({ post: this.post, voteState: $voteState })
          
          Text("TOP COMMENTS")
            .font-size(14)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.5)
            .fontColor(AppTokens.Colors.outline)
            .margin({ 
              top: AppTokens.Spacing.sm, 
              bottom: AppTokens.Spacing.sm, 
              left: AppTokens.Spacing.lg, 
              right: AppTokens.Spacing.lg 
            })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
          })
          
          // Spacer for bottom bar
          Blank().height(80)
        }
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Bar
      Row() {
        TextInput({ placeholder: 'Add a comment...' })
          .placeholderColor(AppTokens.Colors.outline)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(16)
          .padding({ left: 16 })
          .height(48)
          .layoutWeight(1)
          .margin({ right: 12 })

        Button('POST')
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontWeight(FontWeight.Bold)
          .borderRadius(16)
          .height(48)
          .width(80)
      }
      .width('100%')
      .padding({ 
        left: AppTokens.Spacing.lg, 
        right: AppTokens.Spacing.lg, 
        top: AppTokens.Spacing.md, 
        bottom: AppTokens.Spacing.md 
      })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}