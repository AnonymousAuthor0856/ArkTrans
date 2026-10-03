package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "030FileManageren"
private const val UI_TYPE = "Productivity"
private const val STYLE_THEME = "Monochrome"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF111111)
        val secondary = Color(0xFF333333)
        val tertiary = Color(0xFF555555)
        val background = Color(0xFFFFFFFF)
        val surface = Color(0xFFF9F9F9)
        val surfaceVariant = Color(0xFFEAEAEA)
        val outline = Color(0xFFD0D0D0)
        val success = Color(0xFF16A34A)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFDC2626)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF111111)
        val onSurface = Color(0xFF111111)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 26.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(14.dp)
    }
    object Spacing {
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(4.dp, 8.dp, 4.dp, 0.16f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class FileItem(val name: String, val type: String, val size: String)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val files = listOf(
        FileItem("Report.pdf", "PDF", "2.1 MB"),
        FileItem("Budget.xlsx", "Spreadsheet", "1.2 MB"),
        FileItem("Design.psd", "Image", "4.7 MB"),
        FileItem("Presentation.pptx", "Slides", "5.4 MB"),
        FileItem("MeetingNotes.txt", "Text", "64 KB")
    )
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("File Manager", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onSurface) },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.background)
            )
        },
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(AppTokens.Colors.background)
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Text("Recent Files", style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.primary)
            LazyVerticalGrid(
                columns = GridCells.Fixed(2),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                modifier = Modifier.fillMaxSize()
            ) {
                items(files) { file ->
                    Card(
                        shape = AppTokens.Shapes.large,
                        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
                        modifier = Modifier.height(120.dp)
                    ) {
                        Column(
                            modifier = Modifier
                                .fillMaxSize()
                                .padding(AppTokens.Spacing.md),
                            verticalArrangement = Arrangement.SpaceBetween
                        ) {
                            Box(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .height(60.dp)
                                    .background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium),
                                contentAlignment = Alignment.Center
                            ) {
                                Text(file.type, style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.onSurface)
                            }
                            Column {
                                Text(file.name, style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface)
                                Text(file.size, style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.tertiary)
                            }
                        }
                    }
                }
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFFFFFFF)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}