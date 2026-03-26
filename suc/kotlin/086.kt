package com.example.myapplication

import android.os.Bundle
import android.view.View
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Slider
import androidx.compose.material3.SliderDefaults
import androidx.compose.material3.Surface
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.drawscope.Fill
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            // Apply a custom minimal light theme locally
            MaterialTheme(
                colorScheme = MaterialTheme.colorScheme.copy(
                    background = Color.White,
                    surface = Color.White,
                    onBackground = Color.Black,
                    onSurface = Color.Black,
                    primary = Color.Black
                )
            ) {
                // Force hide system bars for immersion
                HideSystemBars()
                BeatMakerApp()
            }
        }
    }
}

// -----------------------------------------------------------------------------------
// System UI Utilities
// -----------------------------------------------------------------------------------

@Composable
fun HideSystemBars() {
    val view = LocalView.current
    if (!view.isInEditMode) {
        SideEffect {
            val window = (view.context as ComponentActivity).window
            window.navigationBarColor = Color.Transparent.toArgb()
            window.statusBarColor = Color.Transparent.toArgb()

            val insetsController = WindowCompat.getInsetsController(window, view)
            insetsController.systemBarsBehavior =
                WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            insetsController.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

// -----------------------------------------------------------------------------------
// Main Screen
// -----------------------------------------------------------------------------------

@Composable
fun BeatMakerApp() {
    // Pure UI State
    var bpm by remember { mutableFloatStateOf(120f) }
    var isPlaying by remember { mutableStateOf(false) }
    var volume by remember { mutableFloatStateOf(0.8f) }

    // Simulate pad states (16 pads)
    val pads = remember { List(16) { mutableStateOf(false) } }

    Surface(
        modifier = Modifier.fillMaxSize(),
        color = Color.White
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(24.dp),
            verticalArrangement = Arrangement.SpaceBetween
        ) {
            // Top Header
            HeaderSection()

            Spacer(modifier = Modifier.height(20.dp))

            // LCD Display / Info Panel
            InfoDisplay(bpm = bpm, isPlaying = isPlaying)

            Spacer(modifier = Modifier.height(24.dp))

            // The Grid (Drum Pads)
            PadGrid(pads = pads)

            Spacer(modifier = Modifier.height(24.dp))

            // Bottom Controls (Sliders and Transport)
            ControlSection(
                bpm = bpm,
                onBpmChange = { bpm = it },
                volume = volume,
                onVolumeChange = { volume = it },
                isPlaying = isPlaying,
                onPlayToggle = { isPlaying = !isPlaying },
                onClear = { pads.forEach { it.value = false } }
            )
        }
    }
}

// -----------------------------------------------------------------------------------
// Components
// -----------------------------------------------------------------------------------

@Composable
fun HeaderSection() {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column {
            Text(
                text = "POCKET",
                fontSize = 14.sp,
                fontWeight = FontWeight.Bold,
                color = Color.Gray,
                letterSpacing = 2.sp
            )
            Text(
                text = "BEATS-909",
                fontSize = 28.sp,
                fontWeight = FontWeight.Black,
                letterSpacing = (-1).sp
            )
        }

        IconButton(onClick = { /* No-op */ }) {
            Icon(
                imageVector = Icons.Default.Settings,
                contentDescription = "Settings",
                tint = Color.Black
            )
        }
    }
}

@Composable
fun InfoDisplay(bpm: Float, isPlaying: Boolean) {
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(80.dp)
            .border(2.dp, Color.Black, RoundedCornerShape(4.dp))
            .background(Color(0xFFF5F5F5))
            .padding(16.dp)
    ) {
        Row(
            modifier = Modifier.fillMaxSize(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Column {
                Text(
                    text = "TEMPO",
                    fontSize = 10.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.Gray
                )
                Text(
                    text = "${bpm.toInt()}",
                    fontSize = 32.sp,
                    fontFamily = androidx.compose.ui.text.font.FontFamily.Monospace,
                    fontWeight = FontWeight.Medium
                )
            }

            Box(
                modifier = Modifier
                    .size(12.dp)
                    .clip(CircleShape)
                    .background(if (isPlaying) Color(0xFFFF5722) else Color.LightGray)
            )
        }
    }
}

@Composable
fun PadGrid(pads: List<androidx.compose.runtime.MutableState<Boolean>>) {
    LazyVerticalGrid(
        columns = GridCells.Fixed(4),
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp),
        modifier = Modifier.fillMaxWidth()
    ) {
        items(16) { index ->
            DrumPad(
                isActive = pads[index].value,
                onClick = { pads[index].value = !pads[index].value },
                label = getPadLabel(index)
            )
        }
    }
}

@Composable
fun DrumPad(isActive: Boolean, onClick: () -> Unit, label: String) {
    // Custom interaction source to remove ripple if desired, keeping it simple here
    Box(
        modifier = Modifier
            .aspectRatio(1f)
            .clip(RoundedCornerShape(8.dp))
            .background(if (isActive) Color.Black else Color(0xFFEEEEEE))
            .clickable { onClick() }
            .border(
                width = 1.dp,
                color = if (isActive) Color.Black else Color(0xFFE0E0E0),
                shape = RoundedCornerShape(8.dp)
            ),
        contentAlignment = Alignment.Center
    ) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            if (isActive) {
                // Draw a little glowing dot using Canvas when active
                Canvas(modifier = Modifier.size(6.dp)) {
                    drawCircle(color = Color.White)
                }
                Spacer(modifier = Modifier.height(4.dp))
            }

            Text(
                text = label,
                fontSize = 10.sp,
                fontWeight = FontWeight.Bold,
                color = if (isActive) Color.White else Color.Gray
            )
        }
    }
}

@Composable
fun ControlSection(
    bpm: Float,
    onBpmChange: (Float) -> Unit,
    volume: Float,
    onVolumeChange: (Float) -> Unit,
    isPlaying: Boolean,
    onPlayToggle: () -> Unit,
    onClear: () -> Unit
) {
    Column(modifier = Modifier.fillMaxWidth()) {
        // Sliders Row
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            Column(modifier = Modifier.weight(1f)) {
                Text("BPM", fontSize = 10.sp, fontWeight = FontWeight.Bold)
                Slider(
                    value = bpm,
                    onValueChange = onBpmChange,
                    valueRange = 60f..200f,
                    colors = SliderDefaults.colors(
                        thumbColor = Color.Black,
                        activeTrackColor = Color.Black,
                        inactiveTrackColor = Color(0xFFE0E0E0)
                    )
                )
            }
            Column(modifier = Modifier.weight(1f)) {
                Text("VOL", fontSize = 10.sp, fontWeight = FontWeight.Bold)
                Slider(
                    value = volume,
                    onValueChange = onVolumeChange,
                    colors = SliderDefaults.colors(
                        thumbColor = Color.Black,
                        activeTrackColor = Color.Black,
                        inactiveTrackColor = Color(0xFFE0E0E0)
                    )
                )
            }
        }

        Spacer(modifier = Modifier.height(24.dp))

        // Transport Buttons
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Clear Button
            CustomOutlinedButton(
                text = "CLEAR",
                icon = Icons.Default.Delete,
                onClick = onClear
            )

            // Play Button (Large)
            Box(
                modifier = Modifier
                    .height(64.dp)
                    .width(140.dp)
                    .clip(RoundedCornerShape(32.dp))
                    .background(Color.Black)
                    .clickable { onPlayToggle() },
                contentAlignment = Alignment.Center
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    // Custom drawn Play/Pause icon to ensure no external icon dep issues
                    Canvas(modifier = Modifier.size(16.dp)) {
                        val path = Path()
                        if (isPlaying) {
                            // Pause symbol (two bars)
                            drawRect(
                                color = Color.White,
                                topLeft = Offset(0f, 0f),
                                size = androidx.compose.ui.geometry.Size(size.width / 3, size.height)
                            )
                            drawRect(
                                color = Color.White,
                                topLeft = Offset(size.width * 2 / 3, 0f),
                                size = androidx.compose.ui.geometry.Size(size.width / 3, size.height)
                            )
                        } else {
                            // Play symbol (triangle)
                            path.moveTo(0f, 0f)
                            path.lineTo(size.width, size.height / 2)
                            path.lineTo(0f, size.height)
                            path.close()
                            drawPath(path, Color.White, style = Fill)
                        }
                    }
                    Spacer(modifier = Modifier.width(12.dp))
                    Text(
                        text = if (isPlaying) "STOP" else "PLAY",
                        color = Color.White,
                        fontWeight = FontWeight.Bold,
                        letterSpacing = 1.sp
                    )
                }
            }
        }
    }
}

@Composable
fun CustomOutlinedButton(text: String, icon: androidx.compose.ui.graphics.vector.ImageVector, onClick: () -> Unit) {
    Box(
        modifier = Modifier
            .height(48.dp)
            .border(1.dp, Color(0xFFE0E0E0), RoundedCornerShape(24.dp))
            .clip(RoundedCornerShape(24.dp))
            .clickable { onClick() }
            .padding(horizontal = 24.dp),
        contentAlignment = Alignment.Center
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Icon(
                imageVector = icon,
                contentDescription = null,
                modifier = Modifier.size(16.dp),
                tint = Color.Gray
            )
            Spacer(modifier = Modifier.width(8.dp))
            Text(
                text = text,
                fontSize = 12.sp,
                fontWeight = FontWeight.Bold,
                color = Color.Black
            )
        }
    }
}

// Helper to label the pads like a drum machine
fun getPadLabel(index: Int): String {
    return when (index) {
        0 -> "KICK"
        1 -> "SNARE"
        2 -> "CLAP"
        3 -> "HI-HAT"
        4 -> "TOM 1"
        5 -> "TOM 2"
        6 -> "CRASH"
        7 -> "RIDE"
        8 -> "PERC 1"
        9 -> "PERC 2"
        10 -> "FX 1"
        11 -> "FX 2"
        else -> "SMP ${index + 1}"
    }
}

@Preview(showBackground = true, widthDp = 360, heightDp = 800)
@Composable
fun AppPreview() {
    BeatMakerApp()
}