package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Divider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Slider
import androidx.compose.material3.SliderDefaults
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import kotlin.math.roundToInt

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 1. Immersive Mode Configuration
        // Hide both Status Bar and Navigation Bar for a full-screen, clean UI
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        
        // Hide system bars immediately
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            // Keep system bars hidden if the UI recomposes or lifecycle changes
            SideEffect {
                windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
            }

            MaterialTheme(
                colorScheme = androidx.compose.material3.lightColorScheme(
                    primary = Color.Black,
                    secondary = Color.Gray,
                    background = Color.White,
                    surface = Color.White,
                    onPrimary = Color.White,
                    onSurface = Color.Black
                )
            ) {
                // Global white background
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = Color.White
                ) {
                    LumenAppScreen()
                }
            }
        }
    }
}

// --- Main Screen ---

@Composable
fun LumenAppScreen() {
    // State for UI interactivity
    var selectedIso by remember { mutableStateOf("400") }
    var apertureValue by remember { mutableFloatStateOf(2.8f) } // Slider value
    var selectedSpeedIndex by remember { mutableStateOf(4) }
    
    val shutterSpeeds = listOf("1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8")

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp),
        verticalArrangement = Arrangement.SpaceBetween
    ) {
        // 1. Header
        HeaderSection()

        // 2. Main Display (The "Shot")
        CurrentSettingsDisplay(
            iso = selectedIso,
            aperture = String.format("%.1f", apertureValue),
            shutter = shutterSpeeds[selectedSpeedIndex]
        )

        // 3. Controls
        Column(verticalArrangement = Arrangement.spacedBy(32.dp)) {
            // ISO Selector
            IsoSelector(
                currentIso = selectedIso,
                onIsoSelected = { selectedIso = it }
            )

            // Aperture Slider
            ApertureControl(
                value = apertureValue,
                onValueChange = { apertureValue = it }
            )
            
            // Shutter Speed Selector
            ShutterSpeedControl(
                speeds = shutterSpeeds,
                selectedIndex = selectedSpeedIndex,
                onSelect = { selectedSpeedIndex = it }
            )
        }

        // 4. Bottom Action
        LogShotButton()
    }
}

// --- Sub-Components ---

@Composable
fun HeaderSection() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(bottom = 16.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column {
            Text(
                text = "LUMEN LOG",
                fontSize = 14.sp,
                fontWeight = FontWeight.Bold,
                letterSpacing = 2.sp,
                color = Color.Gray
            )
            Text(
                text = "Roll #034",
                fontSize = 24.sp,
                fontWeight = FontWeight.ExtraBold,
                color = Color.Black
            )
        }
        
        Row {
            IconButton(onClick = { /* No-op */ }) {
                Icon(
                    imageVector = Icons.Default.Menu,
                    contentDescription = "Menu",
                    tint = Color.Black
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
}

@Composable
fun CurrentSettingsDisplay(iso: String, aperture: String, shutter: String) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .height(160.dp),
        shape = RoundedCornerShape(16.dp),
        colors = CardDefaults.cardColors(containerColor = Color(0xFFF8F8F8)),
        border = BorderStroke(1.dp, Color(0xFFEEEEEE))
    ) {
        Row(
            modifier = Modifier.fillMaxSize(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Aperture (Main Focus)
            Column(
                modifier = Modifier
                    .weight(1.5f)
                    .padding(start = 24.dp),
                verticalArrangement = Arrangement.Center
            ) {
                Text(
                    text = "f/$aperture",
                    fontSize = 56.sp,
                    fontWeight = FontWeight.Light,
                    color = Color.Black,
                    letterSpacing = (-2).sp
                )
                Text(
                    text = "APERTURE",
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.Gray
                )
            }
            
            Divider(
                modifier = Modifier
                    .width(1.dp)
                    .height(80.dp),
                color = Color.LightGray
            )

            // Details Column
            Column(
                modifier = Modifier
                    .weight(1f)
                    .padding(start = 24.dp),
                verticalArrangement = Arrangement.Center
            ) {
                SettingItemSmall(label = "ISO", value = iso)
                Spacer(modifier = Modifier.height(16.dp))
                SettingItemSmall(label = "SHUTTER", value = shutter)
            }
        }
    }
}

@Composable
fun SettingItemSmall(label: String, value: String) {
    Column {
        Text(
            text = value,
            fontSize = 20.sp,
            fontWeight = FontWeight.SemiBold,
            color = Color.Black
        )
        Text(
            text = label,
            fontSize = 10.sp,
            fontWeight = FontWeight.Bold,
            color = Color.Gray
        )
    }
}

@Composable
fun IsoSelector(currentIso: String, onIsoSelected: (String) -> Unit) {
    val isoValues = listOf("100", "200", "400", "800", "1600", "3200")
    
    Column {
        Text(
            text = "Film Stock ISO",
            fontSize = 14.sp,
            fontWeight = FontWeight.Medium,
            modifier = Modifier.padding(bottom = 12.dp)
        )
        LazyRow(
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            items(isoValues) { iso ->
                val isSelected = currentIso == iso
                Box(
                    modifier = Modifier
                        .size(width = 60.dp, height = 36.dp)
                        .clip(RoundedCornerShape(50))
                        .background(if (isSelected) Color.Black else Color.Transparent)
                        .border(
                            width = 1.dp,
                            color = if (isSelected) Color.Black else Color(0xFFE0E0E0),
                            shape = RoundedCornerShape(50)
                        )
                        .clickable { onIsoSelected(iso) },
                    contentAlignment = Alignment.Center
                ) {
                    Text(
                        text = iso,
                        color = if (isSelected) Color.White else Color.Black,
                        fontSize = 13.sp,
                        fontWeight = FontWeight.SemiBold
                    )
                }
            }
        }
    }
}

@Composable
fun ApertureControl(value: Float, onValueChange: (Float) -> Unit) {
    Column {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text(
                text = "Aperture Control",
                fontSize = 14.sp,
                fontWeight = FontWeight.Medium
            )
            // Using a standard icon to represent 'auto' or 'manual' mode loosely
            Icon(
                imageVector = Icons.Default.Settings,
                contentDescription = null,
                modifier = Modifier.size(16.dp),
                tint = Color.Gray
            )
        }
        
        Spacer(modifier = Modifier.height(8.dp))
        
        Slider(
            value = value,
            onValueChange = onValueChange,
            valueRange = 1.4f..16f,
            steps = 20,
            colors = SliderDefaults.colors(
                thumbColor = Color.Black,
                activeTrackColor = Color.Black,
                inactiveTrackColor = Color(0xFFE0E0E0)
            )
        )
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text("f/1.4", fontSize = 12.sp, color = Color.Gray)
            Text("f/16", fontSize = 12.sp, color = Color.Gray)
        }
    }
}

@Composable
fun ShutterSpeedControl(speeds: List<String>, selectedIndex: Int, onSelect: (Int) -> Unit) {
    Column {
        Text(
            text = "Shutter Speed",
            fontSize = 14.sp,
            fontWeight = FontWeight.Medium,
            modifier = Modifier.padding(bottom = 12.dp)
        )
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            // Simplified display of just 3 options for the layout, centered around selection
            val prev = speeds.getOrNull(selectedIndex - 1) ?: "-"
            val curr = speeds[selectedIndex]
            val next = speeds.getOrNull(selectedIndex + 1) ?: "-"
            
            SpeedOption(text = prev, isSelected = false, onClick = { 
                if (selectedIndex > 0) onSelect(selectedIndex - 1) 
            })
            
            SpeedOption(text = curr, isSelected = true, onClick = {})
            
            SpeedOption(text = next, isSelected = false, onClick = {
                if (selectedIndex < speeds.size - 1) onSelect(selectedIndex + 1)
            })
        }
    }
}

@Composable
fun SpeedOption(text: String, isSelected: Boolean, onClick: () -> Unit) {
    Box(
        modifier = Modifier
            .width(100.dp)
            .height(50.dp)
            .clip(RoundedCornerShape(12.dp))
            .background(if (isSelected) Color(0xFFF0F0F0) else Color.Transparent)
            .clickable(enabled = !isSelected && text != "-") { onClick() },
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = text,
            fontSize = if (isSelected) 22.sp else 16.sp,
            fontWeight = if (isSelected) FontWeight.Bold else FontWeight.Normal,
            color = if (isSelected) Color.Black else Color.LightGray
        )
    }
}

@Composable
fun LogShotButton() {
    Button(
        onClick = { /* No-op */ },
        modifier = Modifier
            .fillMaxWidth()
            .height(56.dp),
        colors = ButtonDefaults.buttonColors(
            containerColor = Color.Black,
            contentColor = Color.White
        ),
        shape = RoundedCornerShape(12.dp)
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Box(
                modifier = Modifier
                    .size(24.dp)
                    .background(Color.White, CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.Add,
                    contentDescription = null,
                    tint = Color.Black,
                    modifier = Modifier.size(16.dp)
                )
            }
            Spacer(modifier = Modifier.width(12.dp))
            Text(
                text = "LOG EXPOSURE",
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
                letterSpacing = 1.sp
            )
        }
    }
}

// ---------------------------
// Helpers
// ---------------------------

fun Modifier.border(width: androidx.compose.ui.unit.Dp, color: Color, shape: androidx.compose.ui.graphics.Shape): Modifier {
    return this.then(Modifier.background(color, shape).padding(width).background(Color.White, shape))
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    MaterialTheme {
        LumenAppScreen()
    }
}