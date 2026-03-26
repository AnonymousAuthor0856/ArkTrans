import SwiftUI

@main
struct ForumPostApp: App {
    var body: some Scene {
        WindowGroup {
            ForumPostView()
                .statusBar(hidden: true)
        }
    }
}

struct Author {
    let name: String
    let avatarColor: Color
}

struct Reply: Identifiable {
    let id: Int
    let author: Author
    let timestamp: String
    let text: String
    let votes: Int
}

struct Post {
    let author: Author
    let timestamp: String
    let title: String
    let body: String
    let votes: Int
    let commentCount: Int
}

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0.0, green: 0.898, blue: 1.0)
        static let secondary = Color(red: 1.0, green: 0.0, blue: 0.667)
        static let tertiary = Color(red: 0.462, green: 1.0, blue: 0.012)
        static let background = Color(red: 0.063, green: 0.063, blue: 0.141)
        static let surface = Color(red: 0.11, green: 0.11, blue: 0.227)
        static let surfaceVariant = Color(red: 0.157, green: 0.157, blue: 0.314)
        static let outline = Color(red: 0.267, green: 0.267, blue: 0.416)
        static let warning = Color(red: 1.0, green: 0.839, blue: 0.0)
        static let onPrimary = Color.black
        static let onSurface = Color(red: 0.878, green: 0.878, blue: 1.0)
    }
    
    struct Typography {
        static let title = Font.system(size: 20, weight: .medium) // 增大
        static let headline = Font.system(size: 22, weight: .semibold) // 增大
        static let body = Font.system(size: 18, weight: .regular) // 增大
        static let label = Font.system(size: 16, weight: .medium) // 增大
        static let small = Font.system(size: 14, weight: .medium) // 增大
    }
    
    struct Shapes {
        static let small: CGFloat = 6
        static let medium: CGFloat = 12
        static let large: CGFloat = 20
    }
    
    struct Spacing {
        static let xs: CGFloat = 6
        static let sm: CGFloat = 10
        static let md: CGFloat = 16
        static let lg: CGFloat = 20
        static let xl: CGFloat = 28
    }
}

struct UpVoteArrow: View {
    let color: Color
    
    var body: some View {
        Canvas { context, size in
            let path = Path { path in
                path.move(to: CGPoint(x: size.width / 2, y: 0))
                path.addLine(to: CGPoint(x: size.width, y: size.height / 2))
                path.addLine(to: CGPoint(x: size.width / 2, y: size.height))
                path.addLine(to: CGPoint(x: 0, y: size.height / 2))
                path.closeSubpath()
            }
            context.fill(path, with: .color(color))
        }
        .frame(width: 28, height: 28) // 增大
    }
}

struct AuthorInfo: View {
    let author: Author
    let timestamp: String
    
    var body: some View {
        HStack(spacing: AppTokens.Spacing.sm) {
            ZStack {
                Circle()
                    .fill(author.avatarColor)
                    .frame(width: 28, height: 28) // 增大
                
                Circle()
                    .fill(Color.black.opacity(0.2))
                    .frame(width: 10, height: 10) // 增大
            }
            
            Text(author.name)
                .font(AppTokens.Typography.small)
                .fontWeight(.bold)
                .foregroundColor(author.avatarColor)
            
            Text(timestamp)
                .font(AppTokens.Typography.small)
                .foregroundColor(AppTokens.Colors.outline)
        }
    }
}

struct InfoChip: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(AppTokens.Typography.small)
            .fontWeight(.bold)
            .foregroundColor(AppTokens.Colors.outline)
    }
}

struct PostCard: View {
    let post: Post
    let voteState: Int
    let onVote: (Int) -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: AppTokens.Spacing.md) {
            VStack(spacing: AppTokens.Spacing.sm) {
                Button(action: {
                    onVote(voteState == 1 ? 0 : 1)
                }) {
                    UpVoteArrow(color: voteState == 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline)
                }
                
                Text("\(post.votes + voteState - 1)")
                    .font(AppTokens.Typography.title)
                    .fontWeight(.bold)
                    .foregroundColor(voteState != 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)
                
                Button(action: {
                    onVote(voteState == -1 ? 0 : -1)
                }) {
                    UpVoteArrow(color: voteState == -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline)
                        .rotationEffect(.degrees(180))
                }
            }
            .frame(width: 60) // 放宽投票区域
            
            VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                AuthorInfo(author: post.author, timestamp: post.timestamp)
                
                Text(post.title)
                    .font(AppTokens.Typography.headline)
                    .foregroundColor(AppTokens.Colors.onSurface)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(post.body)
                    .font(AppTokens.Typography.body)
                    .foregroundColor(AppTokens.Colors.onSurface.opacity(0.8))
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack(spacing: AppTokens.Spacing.xl) {
                    InfoChip(text: "\(post.commentCount) Comments")
                    InfoChip(text: "Share")
                }
                .padding(.top, AppTokens.Spacing.sm)
            }
        }
        .padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTokens.Colors.surface)
    }
}

struct ReplyCard: View {
    let reply: Reply
    
    var body: some View {
        HStack(alignment: .top, spacing: AppTokens.Spacing.md) {
            Rectangle()
                .fill(reply.author.avatarColor.opacity(0.5))
                .frame(width: 3) // 增大
                .cornerRadius(1.5)
            
            VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                AuthorInfo(author: reply.author, timestamp: reply.timestamp)
                
                Text(reply.text)
                    .font(AppTokens.Typography.body)
                    .foregroundColor(AppTokens.Colors.onSurface.opacity(0.9))
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack(spacing: AppTokens.Spacing.md) {
                    InfoChip(text: "\(reply.votes) votes")
                    InfoChip(text: "Reply")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TopAppBar: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(AppTokens.Colors.surface)
                .frame(height: 60) // 增大
                .ignoresSafeArea(edges: .top)
            
            HStack {
                Button(action: {}) {
                    ZStack {
                        Canvas { context, size in
                            let centerY = size.height / 2
                            
                            context.stroke(
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: centerY))
                                    path.addLine(to: CGPoint(x: size.width, y: centerY))
                                },
                                with: .color(AppTokens.Colors.primary),
                                lineWidth: 3 // 增大
                            )
                            
                            context.stroke(
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: centerY))
                                    path.addLine(to: CGPoint(x: size.width / 2, y: 0))
                                },
                                with: .color(AppTokens.Colors.primary),
                                lineWidth: 3 // 增大
                            )
                            
                            context.stroke(
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: centerY))
                                    path.addLine(to: CGPoint(x: size.width / 2, y: size.height))
                                },
                                with: .color(AppTokens.Colors.primary),
                                lineWidth: 3 // 增大
                            )
                        }
                        .frame(width: 24, height: 24) // 增大
                    }
                    .frame(width: 50, height: 50) // 增大
                }
                
                Spacer()
                
                Text("r/jetpackcompose")
                    .font(AppTokens.Typography.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                
                Spacer()
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 50, height: 50) // 增大
            }
            .padding(.horizontal, AppTokens.Spacing.lg)
        }
    }
}

struct BottomCommentBar: View {
    @Binding var commentText: String
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(AppTokens.Colors.outline.opacity(0.3))
                .frame(height: 1) // 增大
                .padding(.horizontal, AppTokens.Spacing.lg)
            
            HStack(spacing: AppTokens.Spacing.md) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                        .fill(AppTokens.Colors.surfaceVariant)
                        .frame(height: 52) // 增大
                    
                    if commentText.isEmpty {
                        Text("Add a comment...")
                            .font(AppTokens.Typography.body)
                            .foregroundColor(AppTokens.Colors.outline)
                            .padding(.horizontal, AppTokens.Spacing.lg)
                    }
                    
                    TextField("", text: $commentText)
                        .font(AppTokens.Typography.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .padding(.horizontal, AppTokens.Spacing.lg)
                }
                
                Button(action: {}) {
                    Text("POST")
                        .font(AppTokens.Typography.label)
                        .fontWeight(.bold)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .padding(.horizontal, AppTokens.Spacing.lg)
                        .frame(height: 52) // 增大
                        .background(
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                                .fill(AppTokens.Colors.primary)
                        )
                }
            }
            .padding(.horizontal, AppTokens.Spacing.lg)
            .padding(.vertical, AppTokens.Spacing.md)
            .background(AppTokens.Colors.surface)
        }
    }
}

struct ForumPostView: View {
    @State private var voteState = 1
    @State private var commentText = ""
    
    private let post = Post(
        author: Author(name: "user/compose_master", avatarColor: AppTokens.Colors.tertiary),
        timestamp: "8 hours ago",
        title: "The power of Jetpack Compose for single-file UIs",
        body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
        votes: 1337,
        commentCount: 42
    )
    
    private let replies = [
        Reply(id: 1, author: Author(name: "dev/android_fan", avatarColor: AppTokens.Colors.secondary), timestamp: "7h ago", text: "Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.", votes: 25),
        Reply(id: 2, author: Author(name: "ux/designer_jane", avatarColor: AppTokens.Colors.primary), timestamp: "5h ago", text: "From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.", votes: 18)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            TopAppBar()
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    PostCard(post: post, voteState: voteState, onVote: { newVote in
                        voteState = newVote
                    })
                    
                    Text("TOP COMMENTS")
                        .font(AppTokens.Typography.small)
                        .foregroundColor(AppTokens.Colors.outline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, AppTokens.Spacing.lg)
                        .padding(.vertical, AppTokens.Spacing.sm)
                    
                    ForEach(replies) { reply in
                        ReplyCard(reply: reply)
                            .padding(.horizontal, AppTokens.Spacing.lg)
                            .padding(.vertical, AppTokens.Spacing.sm)
                    }
                }
            }
            .background(AppTokens.Colors.background)
            
            BottomCommentBar(commentText: $commentText)
        }
        .background(AppTokens.Colors.background)
    }
}