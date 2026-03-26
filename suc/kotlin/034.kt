package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "010*ExploreMap*en"
private const val UI_TYPE = "Social"
private const val STYLE_THEME = "Monochrome Terminal"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF00FF66)
        val secondary = Color(0xFFCCCCCC)
        val tertiary = Color(0xFF999999)
        val background = Color(0xFF000000)
        val surface = Color(0xFF0A0A0A)
        val surfaceVariant = Color(0xFF111111)
        val outline = Color(0xFF1F1F1F)
        val success = Color(0xFF16A34A)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFFF4444)
        val onPrimary = Color(0xFF000000)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFFE0E0E0)
        val onSurface = Color(0xFFE0E0E0)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.Medium)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 13.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 11.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(14.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 32.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(0.dp, 0.dp, 0.dp, 0f)
        val level2 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
    }
}

private val AppColorScheme = darkColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
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
    headlineMedium = AppTokens.TypographyTokens.headline,
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

data class MapMarker(val name: String, val distance: String)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    var query by remember { mutableStateOf("") }
    val markers = remember {
        listOf(
            MapMarker("Central Plaza", "1.2 km"),
            MapMarker("Museum District", "3.4 km"),
            MapMarker("Tech Park", "5.6 km"),
            MapMarker("Old Town Gate", "7.8 km")
        )
    }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Text(
                        "Explore Map",
                        style = MaterialTheme.typography.displayLarge,
                        color = AppTokens.Colors.primary
                    )
                },
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
            OutlinedTextField(
                value = query,
                onValueChange = { query = it },
                label = { Text("Search destination", color = AppTokens.Colors.onSurface) },
                singleLine = true,
                shape = AppTokens.Shapes.medium,
                colors = OutlinedTextFieldDefaults.colors(
                    focusedTextColor = AppTokens.Colors.onSurface,
                    unfocusedTextColor = AppTokens.Colors.onSurface,
                    cursorColor = AppTokens.Colors.primary,
                    focusedBorderColor = AppTokens.Colors.primary,
                    unfocusedBorderColor = AppTokens.Colors.outline
                ),
                modifier = Modifier.fillMaxWidth()
            )
            Column(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
            ) {
                markers.forEach {
                    Card(
                        modifier = Modifier.fillMaxWidth(),
                        shape = AppTokens.Shapes.medium,
                        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation)
                    ) {
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(AppTokens.Spacing.md),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Column {
                                Text(it.name, style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface)
                                Text(it.distance, style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.secondary)
                            }
                            Button(
                                onClick = {},
                                shape = AppTokens.Shapes.small,
                                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary)
                            ) {
                                Text("View", style = MaterialTheme.typography.labelMedium)
                            }
                        }
                    }
                }
            }
            Spacer(modifier = Modifier.height(AppTokens.Spacing.xxl))
            Button(
                onClick = {},
                modifier = Modifier.fillMaxWidth().height(48.dp),
                shape = AppTokens.Shapes.large,
                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary)
            ) {
                Text("Refresh Map", style = MaterialTheme.typography.titleMedium)
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

@Preview(showBackground = true, backgroundColor = 0xFF000000)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}
